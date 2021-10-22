Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1539D437B8D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhJVRNq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 13:13:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:8306 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhJVRN3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 13:13:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="252848925"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="252848925"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 10:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="633393274"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2021 10:11:09 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] tools: Introduce power/acpi/pfru/pfru
Date:   Sat, 23 Oct 2021 01:10:32 +0800
Message-Id: <0159379f2f15c79959fd597874f162ebc3cf711b.1634899519.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634899519.git.yu.c.chen@intel.com>
References: <cover.1634899519.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce a user space tool to make use of the interface exposed by
Platform Firmware Runtime Update and Telemetry drivers. The users
can use this tool to do firmware code injection, driver update and
to retrieve the telemetry data.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v5: Replace the read() with mmap() so that the userspace
    could mmap once, and read multiple times. (Greg Kroah-Hartman)
---
 include/uapi/linux/pfru.h      |   5 +
 tools/power/acpi/pfru/Makefile |  25 ++
 tools/power/acpi/pfru/pfru.8   | 137 +++++++++++
 tools/power/acpi/pfru/pfru.c   | 407 +++++++++++++++++++++++++++++++++
 4 files changed, 574 insertions(+)
 create mode 100644 tools/power/acpi/pfru/Makefile
 create mode 100644 tools/power/acpi/pfru/pfru.8
 create mode 100644 tools/power/acpi/pfru/pfru.c

diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index 01f0224f3d0a..7c31c3f7870a 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -8,7 +8,12 @@
 #define __PFRU_H__
 
 #include <linux/ioctl.h>
+#ifdef __KERNEL__
 #include <linux/uuid.h>
+#else
+#include <uuid/uuid.h>
+#include <linux/types.h>
+#endif
 
 #define PFRU_UUID		"ECF9533B-4A3C-4E89-939E-C77112601C6D"
 #define PFRU_CODE_INJ_UUID		"B2F84B79-7B6E-4E45-885F-3FB9BB185402"
diff --git a/tools/power/acpi/pfru/Makefile b/tools/power/acpi/pfru/Makefile
new file mode 100644
index 000000000000..54bf913b2a09
--- /dev/null
+++ b/tools/power/acpi/pfru/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+CFLAGS += -Wall -O2
+CFLAGS += -DPFRU_HEADER='"../../../../include/uapi/linux/pfru.h"'
+BUILD_OUTPUT	:= $(CURDIR)
+
+ifeq ("$(origin O)", "command line")
+	BUILD_OUTPUT := $(O)
+endif
+
+pfru : pfru.c
+
+%: %.c
+	@mkdir -p $(BUILD_OUTPUT)
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -luuid
+
+.PHONY : clean
+clean :
+	@rm -f $(BUILD_OUTPUT)/pfru
+
+install : pfru
+	install -d  $(DESTDIR)$(PREFIX)/bin
+	install $(BUILD_OUTPUT)/pfru $(DESTDIR)$(PREFIX)/bin/pfru
+	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
+	install -m 644 pfru.8 $(DESTDIR)$(PREFIX)/share/man/man8
diff --git a/tools/power/acpi/pfru/pfru.8 b/tools/power/acpi/pfru/pfru.8
new file mode 100644
index 000000000000..d9cda7beaa3c
--- /dev/null
+++ b/tools/power/acpi/pfru/pfru.8
@@ -0,0 +1,137 @@
+.TH "PFRU" "8" "October 2021" "pfru 1.0" ""
+.hy
+.SH Name
+.PP
+pfru \- Platform Firmware Runtime Update tool
+.SH SYNOPSIS
+.PP
+\f[B]pfru\f[R] [\f[I]Options\f[R]]
+.SH DESCRIPTION
+.PP
+The PFRU(Platform Firmware Runtime Update) kernel interface is designed
+to
+.PD 0
+.P
+.PD
+interact with the platform firmware interface defined in the
+.PD 0
+.P
+.PD
+Management Mode Firmware Runtime
+Update (https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf)
+.PD 0
+.P
+.PD
+\f[B]pfru\f[R] is the tool to interact with the kernel interface.
+.PD 0
+.P
+.PD
+.SH OPTIONS
+.TP
+.B \f[B]\-h\f[R], \f[B]\-\-help\f[R]
+Display helper information.
+.TP
+.B \f[B]\-l\f[R], \f[B]\-\-load\f[R]
+Load the capsule file into the system.
+To be more specific, the capsule file will be copied to the
+communication buffer.
+.TP
+.B \f[B]\-s\f[R], \f[B]\-\-stage\f[R]
+Stage the capsule image from communication buffer into Management Mode
+and perform authentication.
+.TP
+.B \f[B]\-a\f[R], \f[B]\-\-activate\f[R]
+Activate a previous staged capsule image.
+.TP
+.B \f[B]\-u\f[R], \f[B]\-\-update\f[R]
+Perform both stage and activation actions.
+.TP
+.B \f[B]\-q\f[R], \f[B]\-\-query\f[R]
+Query the update capability.
+.TP
+.B \f[B]\-d\f[R], \f[B]\-\-setrev\f[R]
+Set the revision ID of code injection/driver update.
+.TP
+.B \f[B]\-D\f[R], \f[B]\-\-setrevlog\f[R]
+Set the revision ID of telemetry.
+.TP
+.B \f[B]\-G\f[R], \f[B]\-\-getloginfo\f[R]
+Get telemetry log information and print it out.
+.TP
+.B \f[B]\-T\f[R], \f[B]\-\-type\f[R]
+Set the telemetry log data type.
+.TP
+.B \f[B]\-L\f[R], \f[B]\-\-level\f[R]
+Set the telemetry log level.
+.TP
+.B \f[B]\-R\f[R], \f[B]\-\-read\f[R]
+Read all the telemetry data and print it out.
+.SH EXAMPLES
+.PP
+\f[B]pfru \-G\f[R]
+.PP
+log_level:4
+.PD 0
+.P
+.PD
+log_type:0
+.PD 0
+.P
+.PD
+log_revid:2
+.PD 0
+.P
+.PD
+max_data_size:65536
+.PD 0
+.P
+.PD
+chunk1_size:0
+.PD 0
+.P
+.PD
+chunk2_size:1401
+.PD 0
+.P
+.PD
+rollover_cnt:0
+.PD 0
+.P
+.PD
+reset_cnt:4
+.PP
+\f[B]pfru \-q\f[R]
+.PP
+code injection image type:794bf8b2\-6e7b\-454e\-885f\-3fb9bb185402
+.PD 0
+.P
+.PD
+fw_version:0
+.PD 0
+.P
+.PD
+code_rt_version:1
+.PD 0
+.P
+.PD
+driver update image type:0e5f0b14\-f849\-7945\-ad81\-bc7b6d2bb245
+.PD 0
+.P
+.PD
+drv_rt_version:0
+.PD 0
+.P
+.PD
+drv_svn:0
+.PD 0
+.P
+.PD
+platform id:39214663\-b1a8\-4eaa\-9024\-f2bb53ea4723
+.PD 0
+.P
+.PD
+oem id:a36db54f\-ea2a\-e14e\-b7c4\-b5780e51ba3d
+.PP
+\f[B]pfru \-l yours.cap \-u \-T 1 \-L 4\f[R]
+.SH AUTHORS
+Chen Yu.
diff --git a/tools/power/acpi/pfru/pfru.c b/tools/power/acpi/pfru/pfru.c
new file mode 100644
index 000000000000..614388ec94df
--- /dev/null
+++ b/tools/power/acpi/pfru/pfru.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform Firmware Runtime Update tool to do Management
+ * Mode code injection/driver update and telemetry retrieval.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include PFRU_HEADER
+
+char *capsule_name;
+int action, query_cap, log_type, log_level, log_read, log_getinfo,
+	revid, log_revid;
+int set_log_level, set_log_type,
+	set_revid, set_log_revid;
+
+char *progname;
+
+static int valid_log_level(int level)
+{
+	return level == LOG_ERR || level == LOG_WARN ||
+		level == LOG_INFO || level == LOG_VERB;
+}
+
+static int valid_log_type(int type)
+{
+	return type == LOG_EXEC_IDX || type == LOG_HISTORY_IDX;
+}
+
+static void help(void)
+{
+	fprintf(stderr,
+		"usage: %s [OPTIONS]\n"
+		" code injection:\n"
+		"  -l, --load\n"
+		"  -s, --stage\n"
+		"  -a, --activate\n"
+		"  -u, --update [stage and activate]\n"
+		"  -q, --query\n"
+		"  -d, --revid update\n"
+		" telemetry:\n"
+		"  -G, --getloginfo\n"
+		"  -T, --type(0:execution, 1:history)\n"
+		"  -L, --level(0, 1, 2, 4)\n"
+		"  -R, --read\n"
+		"  -D, --revid log\n",
+		progname);
+}
+
+char *option_string = "l:sauqd:GT:L:RD:h";
+static struct option long_options[] = {
+	{"load", required_argument, 0, 'l'},
+	{"stage", no_argument, 0, 's'},
+	{"activate", no_argument, 0, 'a'},
+	{"update", no_argument, 0, 'u'},
+	{"query", no_argument, 0, 'q'},
+	{"getloginfo", no_argument, 0, 'G'},
+	{"type", required_argument, 0, 'T'},
+	{"level", required_argument, 0, 'L'},
+	{"read", no_argument, 0, 'R'},
+	{"setrev", required_argument, 0, 'd'},
+	{"setrevlog", required_argument, 0, 'D'},
+	{"help", no_argument, 0, 'h'},
+	{}
+};
+
+static void parse_options(int argc, char **argv)
+{
+	char *pathname;
+	int c;
+
+	pathname = strdup(argv[0]);
+	progname = basename(pathname);
+
+	while (1) {
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, option_string,
+				long_options, &option_index);
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'l':
+			capsule_name = optarg;
+			break;
+		case 's':
+			action = 1;
+			break;
+		case 'a':
+			action = 2;
+			break;
+		case 'u':
+			action = 3;
+			break;
+		case 'q':
+			query_cap = 1;
+			break;
+		case 'G':
+			log_getinfo = 1;
+			break;
+		case 'T':
+			log_type = atoi(optarg);
+			set_log_type = 1;
+			break;
+		case 'L':
+			log_level = atoi(optarg);
+			set_log_level = 1;
+			break;
+		case 'R':
+			log_read = 1;
+			break;
+		case 'd':
+			revid = atoi(optarg);
+			set_revid = 1;
+			break;
+		case 'D':
+			log_revid = atoi(optarg);
+			set_log_revid = 1;
+			break;
+		case 'h':
+			help();
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void print_cap(struct pfru_update_cap_info *cap)
+{
+	char *uuid = malloc(37);
+
+	if (!uuid) {
+		perror("Can not allocate uuid buffer\n");
+		exit(1);
+	}
+
+	uuid_unparse(cap->code_type, uuid);
+	printf("code injection image type:%s\n", uuid);
+	printf("fw_version:%d\n", cap->fw_version);
+	printf("code_rt_version:%d\n", cap->code_rt_version);
+
+	uuid_unparse(cap->drv_type, uuid);
+	printf("driver update image type:%s\n", uuid);
+	printf("drv_rt_version:%d\n", cap->drv_rt_version);
+	printf("drv_svn:%d\n", cap->drv_svn);
+
+	uuid_unparse(cap->platform_id, uuid);
+	printf("platform id:%s\n", uuid);
+	uuid_unparse(cap->oem_id, uuid);
+	printf("oem id:%s\n", uuid);
+
+	free(uuid);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd_update, fd_update_log, fd_capsule;
+	struct pfru_log_data_info data_info;
+	struct pfru_log_info info;
+	struct pfru_update_cap_info cap;
+	void *addr_map_capsule;
+	struct stat st;
+	char *log_buf;
+	int ret = 0;
+
+	if (getuid() != 0) {
+		printf("Please run the tool as root - Exiting.\n");
+		return 1;
+	}
+
+	parse_options(argc, argv);
+
+	fd_update = open("/dev/acpi_pfru0", O_RDWR);
+	if (fd_update < 0) {
+		printf("PFRU device not supported - Quit...\n");
+		return 1;
+	}
+
+	fd_update_log = open("/dev/acpi_pfru_telemetry0", O_RDWR);
+	if (fd_update_log < 0) {
+		printf("PFRU telemetry device not supported - Quit...\n");
+		return 1;
+	}
+
+	if (query_cap) {
+		ret = ioctl(fd_update, PFRU_IOC_QUERY_CAP, &cap);
+		if (ret)
+			perror("Query Update Capability info failed.");
+		else
+			print_cap(&cap);
+
+		close(fd_update);
+		close(fd_update_log);
+
+		return ret;
+	}
+
+	if (log_getinfo) {
+		ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_DATA_INFO, &data_info);
+		if (ret) {
+			perror("Get telemetry data info failed.");
+
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_INFO, &info);
+		if (ret) {
+			perror("Get telemetry info failed.");
+
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		printf("log_level:%d\n", info.log_level);
+		printf("log_type:%d\n", info.log_type);
+		printf("log_revid:%d\n", info.log_revid);
+		printf("max_data_size:%d\n", data_info.max_data_size);
+		printf("chunk1_size:%d\n", data_info.chunk1_size);
+		printf("chunk2_size:%d\n", data_info.chunk2_size);
+		printf("rollover_cnt:%d\n", data_info.rollover_cnt);
+		printf("reset_cnt:%d\n", data_info.reset_cnt);
+
+		return 0;
+	}
+
+	info.log_level = -1;
+	info.log_type = -1;
+	info.log_revid = -1;
+
+	if (set_log_level) {
+		if (!valid_log_level(log_level)) {
+			printf("Invalid log level %d\n",
+			       log_level);
+		} else {
+			info.log_level = log_level;
+		}
+	}
+
+	if (set_log_type) {
+		if (!valid_log_type(log_type)) {
+			printf("Invalid log type %d\n",
+			       log_type);
+		} else {
+			info.log_type = log_type;
+		}
+	}
+
+	if (set_log_revid) {
+		if (!pfru_valid_revid(log_revid)) {
+			printf("Invalid log revid %d, unchanged.\n",
+			       log_revid);
+		} else {
+			info.log_revid = log_revid;
+		}
+	}
+
+	ret = ioctl(fd_update_log, PFRU_LOG_IOC_SET_INFO, &info);
+	if (ret) {
+		perror("Log information set failed.(log_level, log_type, log_revid)");
+
+		close(fd_update);
+		close(fd_update_log);
+
+		return 1;
+	}
+
+	if (set_revid) {
+		ret = ioctl(fd_update, PFRU_IOC_SET_REV, &revid);
+		if (ret) {
+			perror("pfru update revid set failed");
+
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		printf("pfru update revid set to %d\n", revid);
+	}
+
+	if (capsule_name) {
+		fd_capsule = open(capsule_name, O_RDONLY);
+		if (fd_capsule < 0) {
+			perror("Can not open capsule file...");
+
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		if (fstat(fd_capsule, &st) < 0) {
+			perror("Can not fstat capsule file...");
+
+			close(fd_capsule);
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		addr_map_capsule = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED,
+					fd_capsule, 0);
+		if (addr_map_capsule == MAP_FAILED) {
+			perror("Failed to mmap capsule file.");
+
+			close(fd_capsule);
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		ret = write(fd_update, (char *)addr_map_capsule, st.st_size);
+		printf("Load %d bytes of capsule file into the system\n",
+		       ret);
+
+		if (ret == -1) {
+			perror("Failed to load capsule file");
+
+			close(fd_capsule);
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		munmap(addr_map_capsule, st.st_size);
+		close(fd_capsule);
+		printf("Load done.\n");
+	}
+
+	if (action) {
+		if (action == 1) {
+			ret = ioctl(fd_update, PFRU_IOC_STAGE, NULL);
+		} else if (action == 2) {
+			ret = ioctl(fd_update, PFRU_IOC_ACTIVATE, NULL);
+		} else if (action == 3) {
+			ret = ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE, NULL);
+		} else {
+			close(fd_update);
+			close(fd_update_log);
+
+			return 1;
+		}
+		printf("Update finished, return %d\n", ret);
+	}
+
+	close(fd_update);
+
+	if (log_read) {
+		void *p_mmap;
+		int max_data_sz;
+
+		ret = ioctl(fd_update_log, PFRU_LOG_IOC_GET_DATA_INFO, &data_info);
+		if (ret) {
+			perror("Get telemetry data info failed.");
+
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		max_data_sz = data_info.max_data_size;
+		log_buf = malloc(max_data_sz + 1);
+		if (!log_buf) {
+			perror("log_buf allocate failed.");
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		p_mmap = mmap(NULL, max_data_sz, PROT_READ, MAP_SHARED, fd_update_log, 0);
+		if (p_mmap == MAP_FAILED) {
+			perror("mmap error.");
+			close(fd_update_log);
+
+			return 1;
+		}
+
+		memcpy(log_buf, p_mmap, max_data_sz);
+		log_buf[max_data_sz] = '\0';
+		printf("%s\n", log_buf);
+		free(log_buf);
+
+		munmap(p_mmap, max_data_sz);
+	}
+
+	close(fd_update_log);
+
+	return 0;
+}
-- 
2.25.1

