Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A341E2FF9B1
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 02:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbhAVA6i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:58:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:35006 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAVA6a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 19:58:30 -0500
IronPort-SDR: GTcjyvmwZ79Jym/ubvVIZGXSZH2QZpmWmZ5vkNKoOTZqKkhGHRohvt/ivuWA0C7bukSkzc/T+4
 OA+FMvOznVnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="240908710"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="240908710"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 16:56:22 -0800
IronPort-SDR: KzwYIucmcdV49YJwvXCqNm7Uf1qd8OIbMOnxBCyw+kRp5vTJtej3MiQkJePOTiznuz1OOPU0kJ
 ECK9A+poeozQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427595534"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 16:56:21 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 3/9] ACPICA: ACPICA: fix -Wfallthrough
Date:   Thu, 21 Jan 2021 16:23:51 -0800
Message-Id: <20210122002357.370836-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122002357.370836-1-erik.kaneda@intel.com>
References: <20210122002357.370836-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

ACPICA commit 4b9135f5774caa796ddf826448811e8e7f08ef2f

GCC 7.1 gained -Wimplicit-fallthrough to warn on implicit fallthrough,
as well as __attribute__((__fallthrough__)) and comments to explicitly
denote that cases of fallthrough were intentional. Clang also supports
this warning and statement attribute, but not the comment form.

Robert Moore provides additional context about the lint comments being
removed. They were for "an old version of PC-Lint, which we don't use
anymore." Drop those.

This will help us enable -Wimplicit-fallthrough throughout the Linux
kernel.

Suggested-by: Robert Moore <robert.moore@intel.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>

Link: https://github.com/acpica/acpica/commit/4b9135f5
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dscontrol.c |  2 +-
 drivers/acpi/acpica/dswexec.c   |  3 +--
 drivers/acpi/acpica/dswload.c   |  2 +-
 drivers/acpi/acpica/dswload2.c  |  2 +-
 drivers/acpi/acpica/exfldio.c   |  2 +-
 drivers/acpi/acpica/exresop.c   |  4 ++--
 drivers/acpi/acpica/exstore.c   |  4 ++--
 drivers/acpi/acpica/hwgpe.c     |  2 +-
 drivers/acpi/acpica/utdelete.c  |  2 +-
 include/acpi/actypes.h          |  6 ++++++
 include/acpi/platform/acgcc.h   | 15 +++++++++++++++
 11 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 4b5b6e859f62..b58ffc7acdb9 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -62,7 +62,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 			}
 		}
 
-		/*lint -fallthrough */
+		ACPI_FALLTHROUGH;
 
 	case AML_IF_OP:
 		/*
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 1d4f8c81028c..4a9799246fae 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -598,8 +598,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 					break;
 				}
 
-				/* Fall through */
-				/*lint -fallthrough */
+				ACPI_FALLTHROUGH;
 
 			case AML_INT_EVAL_SUBTREE_OP:
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 27069325b6de..dd97c86f8e41 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -224,7 +224,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 				break;
 			}
 
-			/*lint -fallthrough */
+			ACPI_FALLTHROUGH;
 
 		default:
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index edadbe146506..d9a3dfca7555 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -214,7 +214,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 				break;
 			}
 
-			/*lint -fallthrough */
+			ACPI_FALLTHROUGH;
 
 		default:
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ade35ff1c7ba..cde24e0fa6a8 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -434,7 +434,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		 * region_field case and write the datum to the Operation Region
 		 */
 
-		/*lint -fallthrough */
+		ACPI_FALLTHROUGH;
 
 	case ACPI_TYPE_LOCAL_REGION_FIELD:
 		/*
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 4d1b22971d58..4a0f8b8bfe62 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -198,7 +198,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 					target_op = AML_DEBUG_OP;
 
-					/*lint -fallthrough */
+					ACPI_FALLTHROUGH;
 
 				case ACPI_REFCLASS_ARG:
 				case ACPI_REFCLASS_LOCAL:
@@ -264,7 +264,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * Else not a string - fall through to the normal Reference
 			 * case below
 			 */
-			/*lint -fallthrough */
+			ACPI_FALLTHROUGH;
 
 		case ARGI_REFERENCE:	/* References: */
 		case ARGI_INTEGER_REF:
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 3adc0a29d890..8fe33051275d 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -96,7 +96,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 			return_ACPI_STATUS(AE_OK);
 		}
 
-		/*lint -fallthrough */
+		ACPI_FALLTHROUGH;
 
 	default:
 
@@ -422,7 +422,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 				break;
 			}
 
-			/* Fallthrough */
+			ACPI_FALLTHROUGH;
 
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_EVENT:
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index b13a4ed5bc63..0c84300e915c 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -167,7 +167,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 			return (AE_BAD_PARAMETER);
 		}
 
-		/*lint -fallthrough */
+		ACPI_FALLTHROUGH;
 
 	case ACPI_GPE_ENABLE:
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 4c0d4e434196..624a26794d55 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -112,7 +112,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 						       gpe_block);
 		}
 
-		/*lint -fallthrough */
+		ACPI_FALLTHROUGH;
 
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_THERMAL:
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 647cb11d0a0a..2a32593691bc 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1286,4 +1286,10 @@ typedef enum {
 
 #define ACPI_OPT_END                    -1
 
+/* Definitions for explicit fallthrough */
+
+#ifndef ACPI_FALLTHROUGH
+#define ACPI_FALLTHROUGH do {} while(0)
+#endif
+
 #endif				/* __ACTYPES_H__ */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 7d63d03cf507..91f7a02c798a 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -54,4 +54,19 @@ typedef __builtin_va_list va_list;
 
 #define ACPI_USE_NATIVE_MATH64
 
+/* GCC did not support __has_attribute until 5.1. */
+
+#ifndef __has_attribute
+#define __has_attribute(x) 0
+#endif
+
+/*
+ * Explictly mark intentional explicit fallthrough to silence
+ * -Wimplicit-fallthrough in GCC 7.1+.
+ */
+
+#if __has_attribute(__fallthrough__)
+#define ACPI_FALLTHROUGH __attribute__((__fallthrough__))
+#endif
+
 #endif				/* __ACGCC_H__ */
-- 
2.29.2

