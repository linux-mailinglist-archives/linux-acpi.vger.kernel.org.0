Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04690A90
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfHPV6e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:56320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfHPV6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381374"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:32 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 2/9] ACPICA: Increase total number of possible Owner IDs
Date:   Fri, 16 Aug 2019 14:43:21 -0700
Message-Id: <20190816214328.3900-3-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 1f1652dad88b9d767767bc1f7eb4f7d99e6b5324

From 255 to 4095 possible IDs.


Link: https://github.com/acpica/acpica/commit/1f1652da
Reported-by: Hedi Berriche <hedi.berriche @hpe.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |  4 ++--
 drivers/acpi/acpica/acobject.h  |  2 +-
 drivers/acpi/acpica/acstruct.h  |  2 +-
 drivers/acpi/acpica/acutils.h   |  7 ++++---
 drivers/acpi/acpica/dbmethod.c  |  4 ++++
 drivers/acpi/acpica/exdump.c    |  6 +++---
 drivers/acpi/acpica/nsalloc.c   |  2 +-
 drivers/acpi/acpica/nsdump.c    |  2 +-
 drivers/acpi/acpica/tbdata.c    |  1 +
 drivers/acpi/acpica/uterror.c   |  6 +++---
 drivers/acpi/acpica/utownerid.c | 12 ++++++------
 include/acpi/acconfig.h         |  4 ++--
 include/acpi/actypes.h          |  4 ++--
 13 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 13d513b81589..1ea52576f0a2 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -134,12 +134,12 @@ struct acpi_namespace_node {
 	union acpi_operand_object *object;	/* Interpreter object */
 	u8 descriptor_type;	/* Differentiate object descriptor types */
 	u8 type;		/* ACPI Type associated with this name */
-	u8 flags;		/* Miscellaneous flags */
-	acpi_owner_id owner_id;	/* Node creator */
+	u16 flags;		/* Miscellaneous flags */
 	union acpi_name_union name;	/* ACPI Name, always 4 chars per ACPI spec */
 	struct acpi_namespace_node *parent;	/* Parent node */
 	struct acpi_namespace_node *child;	/* First child */
 	struct acpi_namespace_node *peer;	/* First peer */
+	acpi_owner_id owner_id;	/* Node creator */
 
 	/*
 	 * The following fields are used by the ASL compiler and disassembler only
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index b2ef703d7df8..8def0e3d690f 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -153,8 +153,8 @@ struct acpi_object_method {
 	} dispatch;
 
 	u32 aml_length;
-	u8 thread_count;
 	acpi_owner_id owner_id;
+	u8 thread_count;
 };
 
 /* Flags for info_flags field above */
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 8a4e6b4aaf2c..218ff4c8b817 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -167,9 +167,9 @@ struct acpi_evaluate_info {
 	u32 return_flags;	/* Used for return value analysis */
 	u32 return_btype;	/* Bitmapped type of the returned object */
 	u16 param_count;	/* Count of the input argument list */
+	u16 node_flags;		/* Same as Node->Flags */
 	u8 pass_number;		/* Parser pass number */
 	u8 return_object_type;	/* Object type of the returned object */
-	u8 node_flags;		/* Same as Node->Flags */
 	u8 flags;		/* General flags */
 };
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 9022537567e9..bcbc51a92dde 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -690,18 +690,19 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_warning(const char *module_name,
 			   u32 line_number,
 			   char *pathname,
-			   u8 node_flags, const char *format, ...);
+			   u16 node_flags, const char *format, ...);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_info(const char *module_name,
 			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...);
+			char *pathname,
+			u16 node_flags, const char *format, ...);
 
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_bios_error(const char *module_name,
 			      u32 line_number,
 			      char *pathname,
-			      u8 node_flags, const char *format, ...);
+			      u16 node_flags, const char *format, ...);
 
 void
 acpi_ut_prefixed_namespace_error(const char *module_name,
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index d8b7a0fe92ec..76a15b6ffc5d 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -302,6 +302,10 @@ acpi_status acpi_db_disassemble_method(char *name)
 	}
 
 	status = acpi_ut_allocate_owner_id(&obj_desc->method.owner_id);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
 	walk_state->owner_id = obj_desc->method.owner_id;
 
 	/* Push start scope on scope stack and make it current */
diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
index 6526b2deeaad..a9bc938a3b55 100644
--- a/drivers/acpi/acpica/exdump.c
+++ b/drivers/acpi/acpica/exdump.c
@@ -94,7 +94,7 @@ static struct acpi_exdump_info acpi_ex_dump_method[9] = {
 	 "Parameter Count"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.sync_level), "Sync Level"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(method.mutex), "Mutex"},
-	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.owner_id), "Owner Id"},
+	{ACPI_EXD_UINT16, ACPI_EXD_OFFSET(method.owner_id), "Owner Id"},
 	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(method.thread_count), "Thread Count"},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(method.aml_length), "Aml Length"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(method.aml_start), "Aml Start"}
@@ -269,8 +269,8 @@ static struct acpi_exdump_info acpi_ex_dump_field_common[7] = {
 
 static struct acpi_exdump_info acpi_ex_dump_node[7] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_node), NULL},
-	{ACPI_EXD_UINT8, ACPI_EXD_NSOFFSET(flags), "Flags"},
-	{ACPI_EXD_UINT8, ACPI_EXD_NSOFFSET(owner_id), "Owner Id"},
+	{ACPI_EXD_UINT16, ACPI_EXD_NSOFFSET(flags), "Flags"},
+	{ACPI_EXD_UINT16, ACPI_EXD_NSOFFSET(owner_id), "Owner Id"},
 	{ACPI_EXD_LIST, ACPI_EXD_NSOFFSET(object), "Object List"},
 	{ACPI_EXD_NODE, ACPI_EXD_NSOFFSET(parent), "Parent"},
 	{ACPI_EXD_NODE, ACPI_EXD_NSOFFSET(child), "Child"},
diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 6eb63db72249..fe9b3639a87d 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -241,7 +241,7 @@ void acpi_ns_install_node(struct acpi_walk_state *walk_state, struct acpi_namesp
 	node->type = (u8) type;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
-			  "%4.4s (%s) [Node %p Owner %X] added to %4.4s (%s) [Node %p]\n",
+			  "%4.4s (%s) [Node %p Owner %3.3X] added to %4.4s (%s) [Node %p]\n",
 			  acpi_ut_get_node_name(node),
 			  acpi_ut_get_type_name(node->type), node, owner_id,
 			  acpi_ut_get_node_name(parent_node),
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 1b12c172e115..9731d7cf1b83 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -197,7 +197,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
 	/* Now we can print out the pertinent information */
 
-	acpi_os_printf(" %-12s %p %2.2X ",
+	acpi_os_printf(" %-12s %p %3.3X ",
 		       acpi_ut_get_type_name(type), this_node,
 		       this_node->owner_id);
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 91a4b984f224..309440010ab2 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -750,6 +750,7 @@ acpi_status acpi_tb_delete_namespace_by_owner(u32 table_index)
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
+
 	acpi_ns_delete_namespace_by_owner(owner_id);
 	acpi_ut_release_write_lock(&acpi_gbl_namespace_rw_lock);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/uterror.c b/drivers/acpi/acpica/uterror.c
index 075457341bad..918aca7c4db4 100644
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -39,7 +39,7 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_warning(const char *module_name,
 			   u32 line_number,
 			   char *pathname,
-			   u8 node_flags, const char *format, ...)
+			   u16 node_flags, const char *format, ...)
 {
 	va_list arg_list;
 
@@ -81,7 +81,7 @@ acpi_ut_predefined_warning(const char *module_name,
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_info(const char *module_name,
 			u32 line_number,
-			char *pathname, u8 node_flags, const char *format, ...)
+			char *pathname, u16 node_flags, const char *format, ...)
 {
 	va_list arg_list;
 
@@ -124,7 +124,7 @@ void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_bios_error(const char *module_name,
 			      u32 line_number,
 			      char *pathname,
-			      u8 node_flags, const char *format, ...)
+			      u16 node_flags, const char *format, ...)
 {
 	va_list arg_list;
 
diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index 5eb8b76ce9d8..d3525ef8ed28 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -38,7 +38,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 
 	if (*owner_id) {
 		ACPI_ERROR((AE_INFO,
-			    "Owner ID [0x%2.2X] already exists", *owner_id));
+			    "Owner ID [0x%3.3X] already exists", *owner_id));
 		return_ACPI_STATUS(AE_ALREADY_EXISTS);
 	}
 
@@ -88,14 +88,14 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 				/*
 				 * Construct encoded ID from the index and bit position
 				 *
-				 * Note: Last [j].k (bit 255) is never used and is marked
+				 * Note: Last [j].k (bit 4095) is never used and is marked
 				 * permanently allocated (prevents +1 overflow)
 				 */
 				*owner_id =
 				    (acpi_owner_id)((k + 1) + ACPI_MUL_32(j));
 
 				ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
-						  "Allocated OwnerId: %2.2X\n",
+						  "Allocated OwnerId: 0x%3.3X\n",
 						  (unsigned int)*owner_id));
 				goto exit;
 			}
@@ -116,7 +116,7 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 	 */
 	status = AE_OWNER_ID_LIMIT;
 	ACPI_ERROR((AE_INFO,
-		    "Could not allocate new OwnerId (255 max), AE_OWNER_ID_LIMIT"));
+		    "Could not allocate new OwnerId (4095 max), AE_OWNER_ID_LIMIT"));
 
 exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
@@ -153,7 +153,7 @@ void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 	/* Zero is not a valid owner_ID */
 
 	if (owner_id == 0) {
-		ACPI_ERROR((AE_INFO, "Invalid OwnerId: 0x%2.2X", owner_id));
+		ACPI_ERROR((AE_INFO, "Invalid OwnerId: 0x%3.3X", owner_id));
 		return_VOID;
 	}
 
@@ -179,7 +179,7 @@ void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 		acpi_gbl_owner_id_mask[index] ^= bit;
 	} else {
 		ACPI_ERROR((AE_INFO,
-			    "Release of non-allocated OwnerId: 0x%2.2X",
+			    "Attempted release of non-allocated OwnerId: 0x%3.3X",
 			    owner_id + 1));
 	}
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 16a83959e616..42d573172e53 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -95,9 +95,9 @@
 
 #define ACPI_DEFAULT_PAGE_SIZE          4096	/* Must be power of 2 */
 
-/* owner_id tracking. 8 entries allows for 255 owner_ids */
+/* owner_id tracking. 128 entries allows for 4095 owner_ids */
 
-#define ACPI_NUM_OWNERID_MASKS          8
+#define ACPI_NUM_OWNERID_MASKS          128
 
 /* Size of the root table array is increased by this increment */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ad6892a24015..e31ef75a22a1 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -442,8 +442,8 @@ typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 
 /* Owner IDs are used to track namespace nodes for selective deletion */
 
-typedef u8 acpi_owner_id;
-#define ACPI_OWNER_ID_MAX               0xFF
+typedef u16 acpi_owner_id;
+#define ACPI_OWNER_ID_MAX               0xFFF	/* 4095 possible owner IDs */
 
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
-- 
2.17.2

