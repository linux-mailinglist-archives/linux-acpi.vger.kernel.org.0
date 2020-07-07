Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7921787D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGGUBv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 16:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgGGUBv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jul 2020 16:01:51 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D27206F6;
        Tue,  7 Jul 2020 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594152110;
        bh=J7lAbC5PPgARB8Nt2T5L13uK1ffYdLf3HflvHSt5qBg=;
        h=Date:From:To:Cc:Subject:From;
        b=q3mb52FUqVTx5yovDjDrabxslQ3GeLovuFs4eRaBZ9RQjGAPdGZT0kHQ/Xvc8zfrA
         HOmoHB96w5qN6H+V2aUeimNepXam53uMF2tyK4iQHS+edl6vs5sEk+zaSAvoHc6MTB
         2+zYMdEUr9YsQIurO4E6l1WgUTGXnfCf6Enfir/0=
Date:   Tue, 7 Jul 2020 15:07:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] ACPICA: Use fallthrough pseudo-keyword
Message-ID: <20200707200716.GA4920@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/acpica/dscontrol.c |    2 +-
 drivers/acpi/acpica/dswexec.c   |    3 +--
 drivers/acpi/acpica/dswload.c   |    2 +-
 drivers/acpi/acpica/dswload2.c  |    4 +---
 drivers/acpi/acpica/exfldio.c   |    2 +-
 drivers/acpi/acpica/exresop.c   |    4 ++--
 drivers/acpi/acpica/exstore.c   |    4 ++--
 drivers/acpi/acpica/hwgpe.c     |    3 +--
 drivers/acpi/acpica/utdelete.c  |    3 +--
 drivers/acpi/acpica/utprint.c   |    2 +-
 10 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/dscontrol.c b/drivers/acpi/acpica/dscontrol.c
index 4b5b6e859f62..134d53380663 100644
--- a/drivers/acpi/acpica/dscontrol.c
+++ b/drivers/acpi/acpica/dscontrol.c
@@ -62,7 +62,7 @@ acpi_ds_exec_begin_control_op(struct acpi_walk_state *walk_state,
 			}
 		}
 
-		/*lint -fallthrough */
+		fallthrough;
 
 	case AML_IF_OP:
 		/*
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 1d4f8c81028c..41f6cb61778a 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -598,8 +598,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 					break;
 				}
 
-				/* Fall through */
-				/*lint -fallthrough */
+				fallthrough;
 
 			case AML_INT_EVAL_SUBTREE_OP:
 
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 27069325b6de..1d8789869dda 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -224,7 +224,7 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 				break;
 			}
 
-			/*lint -fallthrough */
+			fallthrough;
 
 		default:
 
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index edadbe146506..de367e8e4cf4 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -213,9 +213,7 @@ acpi_ds_load2_begin_op(struct acpi_walk_state *walk_state,
 			     parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
 				break;
 			}
-
-			/*lint -fallthrough */
-
+			fallthrough;
 		default:
 
 			/* All other types are an error */
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ade35ff1c7ba..677ba3ab1482 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -434,7 +434,7 @@ acpi_ex_field_datum_io(union acpi_operand_object *obj_desc,
 		 * region_field case and write the datum to the Operation Region
 		 */
 
-		/*lint -fallthrough */
+		fallthrough;
 
 	case ACPI_TYPE_LOCAL_REGION_FIELD:
 		/*
diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 4d1b22971d58..7c8676adcf43 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -198,7 +198,7 @@ acpi_ex_resolve_operands(u16 opcode,
 
 					target_op = AML_DEBUG_OP;
 
-					/*lint -fallthrough */
+					fallthrough;
 
 				case ACPI_REFCLASS_ARG:
 				case ACPI_REFCLASS_LOCAL:
@@ -264,7 +264,7 @@ acpi_ex_resolve_operands(u16 opcode,
 			 * Else not a string - fall through to the normal Reference
 			 * case below
 			 */
-			/*lint -fallthrough */
+			fallthrough;
 
 		case ARGI_REFERENCE:	/* References: */
 		case ARGI_INTEGER_REF:
diff --git a/drivers/acpi/acpica/exstore.c b/drivers/acpi/acpica/exstore.c
index 3adc0a29d890..fcf8dff56c5b 100644
--- a/drivers/acpi/acpica/exstore.c
+++ b/drivers/acpi/acpica/exstore.c
@@ -96,7 +96,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 			return_ACPI_STATUS(AE_OK);
 		}
 
-		/*lint -fallthrough */
+		fallthrough;
 
 	default:
 
@@ -422,7 +422,7 @@ acpi_ex_store_object_to_node(union acpi_operand_object *source_desc,
 				break;
 			}
 
-			/* Fallthrough */
+			fallthrough;
 
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_EVENT:
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 49c46d4dd070..19d574f64c78 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -95,8 +95,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		if (!(register_bit & gpe_register_info->enable_mask)) {
 			return (AE_BAD_PARAMETER);
 		}
-
-		/*lint -fallthrough */
+		fallthrough;
 
 	case ACPI_GPE_ENABLE:
 
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index c365faf4e6cd..6db09eb9d257 100644
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
 

