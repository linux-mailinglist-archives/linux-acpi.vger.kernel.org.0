Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC967EDFD
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjA0TQc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 14:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjA0TQc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 14:16:32 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8957BE56
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 11:16:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9so5972834pll.9
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSndjEFPQ8hAZKvh/r+nd2nnOGer9rU0gXriWQsIEEQ=;
        b=LUcZtXDPuEtFizj4Bs7VHv9wEcnEa5uELvDLcfiOt+HJ0z3U654Zhq92ouD/AvxRyJ
         c4WnLYzr+R+XOlzI0VTTLfmOBHry4yWAT6owaEPUbPYj6oRurSbYPeR2wm02MmeLSkZT
         +xbZgirrx0mRSif3xvfWmnr8a0lC4nShZYmko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSndjEFPQ8hAZKvh/r+nd2nnOGer9rU0gXriWQsIEEQ=;
        b=QFDMsIaNygpsZIdpavmUeWlY43P8lV8uz4weFb1SGNfBDNAyB5i4W+Ddx4wvdhl2yu
         83TkkksweLLHzW45QQlOBhPAJTiqRkSF4BzXZQFwpDbP8Q3zM81U90jwJ72588M36HPH
         ujv8b3ro8d+5SFi9ROPjF1Jkmek0qyauEAcRQKFQ2Sh8Pl/lG1Wd9DC2w6G3X6ISh1uv
         35BwFUiiwxcq2C1woW17FAqrQvTEiW8NY/j46OYSOCNL6UtOQX9+5FJjLjuiqGaxn4ix
         N1Io5oo9MOVkRqMt13OKHN1+sTpcFcLqUeEySfUbFzxxZaBSLazvoeUVHHcND4GJwplo
         MKOg==
X-Gm-Message-State: AFqh2ko5n3GtV1na0wbXRm9O/UAlS4nLvdPTgYvyIC6zm0MlFHHbF/8r
        lVoR+6OM/Xc0WCJ2K9Wcs8L7zw==
X-Google-Smtp-Source: AMrXdXtH1CXKWg2AUOpH/3d9Xy8zYKSQ91rpvEKF2qqiouG2N3QZ/D+6ldssuipVfdd4VOiwXncPnw==
X-Received: by 2002:a17:902:d650:b0:193:13fc:8840 with SMTP id y16-20020a170902d65000b0019313fc8840mr38951507plh.21.1674846989961;
        Fri, 27 Jan 2023 11:16:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902bb8900b0019488090884sm3179644pls.273.2023.01.27.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:16:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible array members
Date:   Fri, 27 Jan 2023 11:16:25 -0800
Message-Id: <20230127191621.gonna.262-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; h=from:subject:message-id; bh=GuYHj8k1bgoDrYd8xgMK12HekFco3rn1yc6XfKftvic=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1CMJvYoAMRsu0wMAJoD56KtcmU8zpzJsIG2mPkda Kr5gyviJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9QjCQAKCRCJcvTf3G3AJo1jEA CJ3BAb/MM8rhQFPA22R+3S7Y5SiuCw4thqyflZIJip4u3apW9Q3pq2TusNrysgAnfATXJdKwowgwt5 QaCYwkfsRjglE68wgcjA3vmcjNIEaFNEo5u49ulY0UTUC83oDdU0Yy9OGiRAIGpDd+cZpHbGreuguw qzNwxCoIRS9WATvILCYcdoj6c5qN5AOg1ZVtOiIeimIW9P03r//Vj+U5pB+XxjutDXMg8/t9KqzVlS 3VilEtucB2flo/RNPuTf3j89WIEj83C5ozYB+9UyNxbMqGn9v2IXrTY36+zPBa9r7K+8lvXm54KBc/ iA9OgrnbsuTqBS1NcxqPfqbSN2SDPiqFrniYX2oJCoHH9r+MhTh5mhkDX3UQbQsDlwpV4PoWw/whNu lCdUufowLczpB08TzO1KjGuNnZVGoTS3GZ9cgMHLUgamLS0SCBFrXRLp4IO6iiuNL7PBrh8Jqx5tEc nisX+chLSWPnPc37aYdKDJEqLPg19Cul7c5tF70ytEKprjVpGDXmTTVQFHH+YHOr4QVEC8+udGZrMQ hb0cPsdaGxGZIOB8ODlSQNcZRYMavA9nhW66okMVO1akfp6oMrXsxbefLIP3RlINcOPSQdE0nKHMam 1eLWpq52IFchwf9YjZS6vxsT+kVoacT99yKwLqcHeQx0KUtaAxcxJYBsLEzQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

One-element arrays (and multi-element arrays being treated as
dynamically sized) are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace one-element array with flexible-array member in struct
acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
padding in a union with a flexible-array member in struct
acpi_pci_routing_table.

This results in no differences in binary output.

Link: https://github.com/acpica/acpica/pull/813
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: include stddef.h and switch to __DECLARE_FLEX_ARRAY()
v1: https://lore.kernel.org/lkml/20221118181538.never.225-kees@kernel.org/
---
 include/acpi/acrestyp.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index a7fb8ddb3dc6..250046a7c870 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -10,6 +10,8 @@
 #ifndef __ACRESTYP_H__
 #define __ACRESTYP_H__
 
+#include <linux/stddef.h>
+
 /*
  * Definitions for Resource Attributes
  */
@@ -332,7 +334,7 @@ struct acpi_resource_extended_irq {
 	u8 wake_capable;
 	u8 interrupt_count;
 	struct acpi_resource_source resource_source;
-	u32 interrupts[1];
+	u32 interrupts[];
 };
 
 struct acpi_resource_generic_register {
@@ -679,7 +681,10 @@ struct acpi_pci_routing_table {
 	u32 pin;
 	u64 address;		/* here for 64-bit alignment */
 	u32 source_index;
-	char source[4];		/* pad to 64 bits so sizeof() works in all cases */
+	union {
+		char pad[4];	/* pad to 64 bits so sizeof() works in all cases */
+		__DECLARE_FLEX_ARRAY(char, source);
+	};
 };
 
 #endif				/* __ACRESTYP_H__ */
-- 
2.34.1

