Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAC2AE637
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 03:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgKKCNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 21:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbgKKCNo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 21:13:44 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01137C0613D1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 18:13:44 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c18so626911qkl.15
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2020 18:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=W+tp6PqByVFyf+7BIq7ovR7ee/HSTPxo+nYyur7x4tk=;
        b=XzskPPUhU0Hn8wLRTfAlu5mkhiWcLvj1r+x5iXEJjeMX6bQk7UG4sZf2gyYw2DXihp
         3dEZhA45Lpgj/Dt/oZOsCoMMCQdgNGJSHAgRKRSZuyqpxoJNX0qJb4AWrWCsXwDpUWK6
         GZgDYa8jNLoiPSSXDMWb1zxqHH3MxX7JmVy6VLph8rU5kH4S+R9RgGsH9GNzbgaugtYG
         2Gw6M+HqModRMimvHPZVhn7I4/8HZPJ9QvuHmymZbTLqOhf/kWCd+5t0BKnAsSoiXOhe
         PpsI71oTKXHMeOsMN3jZ5uBMMQukdvjTyql9zFtCyZTB+mTclThuMvmLQ8YzUSL28eHD
         C7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=W+tp6PqByVFyf+7BIq7ovR7ee/HSTPxo+nYyur7x4tk=;
        b=CNkYTsFN5dPYeLN6+a3ApeufPSFmJrJiNhYn6PbaSHAarLm3BTPYQY6O0Lav+3jeaf
         bkGGJO5Lw6YoRakOPF69dtTuUo8jEhNlQRxlPSRN89tkn9Wj7EEEE+MbKxyoJRv/JRaU
         SKfTu01XUvPEA6plLRJuTEBmEmbUT1RZE/VhaMYC/Fu1V1pe6zBr+JkdMAyZL5dJR9vZ
         8Izp41wTtfbrWvf1pB7la8KLVvDw0DdS+TNDuKpOARER6wJy46EVac99NoncYnXyUKmn
         xqgkh6sbnd5xU3otUzC3rKM4JYhBfjcRgLqkQ5z5xUVe4Pfst2Sm+59BMO+aYyz4HEmR
         qniw==
X-Gm-Message-State: AOAM532K3B8dXewctw43yzmS+yKhYNlsagO9DxdcLPQYpcAbem1eQaOx
        P+GkP7I3r4+Muz8INZPDKvhAG0vQCI0N6rcJ2qw=
X-Google-Smtp-Source: ABdhPJwSC4FdAQLVj6SfNDoGwrqkKbLnTgmDa2ZIoHmS3uffZ7D/LkKe6rXbTfU3q6tJZswSpEWpGS93EBQCcuss4Cs=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:aedf:: with SMTP id
 n31mr16891447qvd.31.1605060823101; Tue, 10 Nov 2020 18:13:43 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:11:30 -0800
Message-Id: <20201111021131.822867-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ACPICA: fix -Wfallthrough
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The "fallthrough" pseudo-keyword was added as a portable way to denote
intentional fallthrough. This code seemed to be using a mix of
fallthrough comments that GCC recognizes, and some kind of lint marker.
I'm guessing that linter hasn't been run in a while from the mixed use
of the marker vs comments.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/acpi/acpica/dscontrol.c | 3 +--
 drivers/acpi/acpica/dswexec.c   | 4 +---
 drivers/acpi/acpica/dswload.c   | 3 +--
 drivers/acpi/acpica/dswload2.c  | 3 +--
 drivers/acpi/acpica/exfldio.c   | 3 +--
 drivers/acpi/acpica/exresop.c   | 5 ++---
 drivers/acpi/acpica/exstore.c   | 6 ++----
 drivers/acpi/acpica/hwgpe.c     | 3 +--
 drivers/acpi/acpica/utdelete.c  | 3 +--
 drivers/acpi/acpica/utprint.c   | 2 +-
 10 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 4b5b6e859f62..1e75e5fbfd19 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -61,8 +61,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 				break;
 			}
 		}
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	case AML_IF_OP:
 		/*
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 1d4f8c81028c..e8c32d4fe55f 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -597,9 +597,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 				if (ACPI_FAILURE(status)) {
 					break;
 				}
-
-				/* Fall through */
-				/*lint -fallthrough */
+				fallthrough;
 
 			case AML_INT_EVAL_SUBTREE_OP:
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 27069325b6de..afc663c3742d 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -223,8 +223,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 			     parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
 				break;
 			}
-
-			/*lint -fallthrough */
+			fallthrough;
 
 		default:
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index edadbe146506..1b794b6ba072 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -213,8 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 			     parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
 				break;
 			}
-
-			/*lint -fallthrough */
+			fallthrough;
 
 		default:
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ade35ff1c7ba..9d1cabe0fed9 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -433,8 +433,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		 * Now that the Bank has been selected, fall through to the
 		 * region_field case and write the datum to the Operation Region
 		 */
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	case ACPI_TYPE_LOCAL_REGION_FIELD:
 		/*
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 4d1b22971d58..df48faa9a551 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -197,8 +197,7 @@ acpi_ex_resolve_operands(u16 opcode,
 				case ACPI_REFCLASS_DEBUG:
 
 					target_op = AML_DEBUG_OP;
-
-					/*lint -fallthrough */
+					fallthrough;
 
 				case ACPI_REFCLASS_ARG:
 				case ACPI_REFCLASS_LOCAL:
@@ -264,7 +263,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * Else not a string - fall through to the normal Reference
 			 * case below
 			 */
-			/*lint -fallthrough */
+			fallthrough;
 
 		case ARGI_REFERENCE:	/* References: */
 		case ARGI_INTEGER_REF:
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 3adc0a29d890..2067baa7c120 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -95,8 +95,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 		if (dest_desc->common.flags & AOPOBJ_AML_CONSTANT) {
 			return_ACPI_STATUS(AE_OK);
 		}
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	default:
 
@@ -421,8 +420,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 				}
 				break;
 			}
-
-			/* Fallthrough */
+			fallthrough;
 
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_EVENT:
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index b13a4ed5bc63..fbfad80c8a53 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -166,8 +166,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		if (!(register_bit & gpe_register_info->enable_mask)) {
 			return (AE_BAD_PARAMETER);
 		}
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	case ACPI_GPE_ENABLE:
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 4c0d4e434196..8076e7947585 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -111,8 +111,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			(void)acpi_ev_delete_gpe_block(object->device.
 						       gpe_block);
 		}
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_THERMAL:
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 681c11f4af4e..f7e43baf5ff2 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		case 'X':
 
 			type |= ACPI_FORMAT_UPPER;
-			/* FALLTHROUGH */
+			fallthrough;
 
 		case 'x':
 
-- 
2.29.2.222.g5d2a92d10f8-goog

