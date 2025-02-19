/*
 Navicat Premium Data Transfer

 Source Server         : xampp
 Source Server Type    : MySQL
 Source Server Version : 100428
 Source Host           : localhost:3306
 Source Schema         : db_sdsanjaya

 Target Server Type    : MySQL
 Target Server Version : 100428
 File Encoding         : 65001

 Date: 16/12/2024 09:43:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_guru
-- ----------------------------
DROP TABLE IF EXISTS `tb_guru`;
CREATE TABLE `tb_guru`  (
  `id_guru` int NOT NULL AUTO_INCREMENT,
  `nama_guru` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jenis_kelamin` enum('LAKI-LAKI','PEREMPUAN') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nomor_telp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_guru`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_guru
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kelas
-- ----------------------------
DROP TABLE IF EXISTS `tb_kelas`;
CREATE TABLE `tb_kelas`  (
  `id_kelas` int NOT NULL AUTO_INCREMENT,
  `nama_kelas` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id_kelas`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kelas
-- ----------------------------

-- ----------------------------
-- Table structure for tb_kelassiswa
-- ----------------------------
DROP TABLE IF EXISTS `tb_kelassiswa`;
CREATE TABLE `tb_kelassiswa`  (
  `id_kelassiswa` int NOT NULL AUTO_INCREMENT,
  `semester` int NOT NULL,
  `tahun` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status_kelassiswa` enum('AKTIF','TIDAK AKTIF') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_siswa` int NULL DEFAULT NULL,
  `id_kelas` int NOT NULL,
  PRIMARY KEY (`id_kelassiswa`) USING BTREE,
  INDEX `id_siswa`(`id_siswa`) USING BTREE,
  INDEX `id_kelas`(`id_kelas`) USING BTREE,
  CONSTRAINT `tb_kelassiswa_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `tb_siswa` (`id_siswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_kelassiswa_ibfk_3` FOREIGN KEY (`id_kelas`) REFERENCES `tb_kelas` (`id_kelas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_kelassiswa
-- ----------------------------

-- ----------------------------
-- Table structure for tb_matapelajaran
-- ----------------------------
DROP TABLE IF EXISTS `tb_matapelajaran`;
CREATE TABLE `tb_matapelajaran`  (
  `id_matapelajaran` int NOT NULL AUTO_INCREMENT,
  `nama_matapelajaran` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_matapelajaran`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_matapelajaran
-- ----------------------------

-- ----------------------------
-- Table structure for tb_penentuan
-- ----------------------------
DROP TABLE IF EXISTS `tb_penentuan`;
CREATE TABLE `tb_penentuan`  (
  `id_penentuan` int NOT NULL AUTO_INCREMENT,
  `status_penentuan` enum('AKTIF','TIDAK AKTIF') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_guru` int NULL DEFAULT NULL,
  `id_matapelajaran` int NULL DEFAULT NULL,
  `jam` time NOT NULL,
  PRIMARY KEY (`id_penentuan`) USING BTREE,
  INDEX `id_guru`(`id_guru`) USING BTREE,
  INDEX `id_matapelajaran`(`id_matapelajaran`) USING BTREE,
  CONSTRAINT `tb_penentuan_ibfk_1` FOREIGN KEY (`id_matapelajaran`) REFERENCES `tb_matapelajaran` (`id_matapelajaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_penentuan_ibfk_2` FOREIGN KEY (`id_guru`) REFERENCES `tb_guru` (`id_guru`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_penentuan
-- ----------------------------

-- ----------------------------
-- Table structure for tb_pengguna
-- ----------------------------
DROP TABLE IF EXISTS `tb_pengguna`;
CREATE TABLE `tb_pengguna`  (
  `id_pengguna` int NOT NULL AUTO_INCREMENT,
  `nama_pengguna` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `level` enum('ADMIN','GURU') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_pengguna`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 157 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_pengguna
-- ----------------------------
INSERT INTO `tb_pengguna` VALUES (1, 'ADMIN', 'admin', 'admin', 'ADMIN');

-- ----------------------------
-- Table structure for tb_presensisiswa
-- ----------------------------
DROP TABLE IF EXISTS `tb_presensisiswa`;
CREATE TABLE `tb_presensisiswa`  (
  `id_presensisiswa` int NOT NULL AUTO_INCREMENT,
  `tanggal_presensisiswa` date NULL DEFAULT NULL,
  `keterangan` enum('ALFA','IZIN','SAKIT','HADIR') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `isi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_kelassiswa` int NULL DEFAULT NULL,
  `id_penentuan` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_presensisiswa`) USING BTREE,
  INDEX `id_kelassiswa`(`id_kelassiswa`) USING BTREE,
  INDEX `id_penentuan`(`id_penentuan`) USING BTREE,
  CONSTRAINT `tb_presensisiswa_ibfk_1` FOREIGN KEY (`id_penentuan`) REFERENCES `tb_penentuan` (`id_penentuan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_presensisiswa_ibfk_2` FOREIGN KEY (`id_kelassiswa`) REFERENCES `tb_kelassiswa` (`id_kelassiswa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_presensisiswa
-- ----------------------------

-- ----------------------------
-- Table structure for tb_siswa
-- ----------------------------
DROP TABLE IF EXISTS `tb_siswa`;
CREATE TABLE `tb_siswa`  (
  `id_siswa` int NOT NULL AUTO_INCREMENT,
  `nama_siswa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nis` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kelas` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `jenis_kelamin` enum('LAKI-LAKI','PEREMPUAN') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tempat_lahir` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `alamat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nomor_telpon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_orangtua` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_siswa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_siswa
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
