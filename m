Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31A82BBC07
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgKUCDZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgKUCDX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2020 21:03:23 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5877C061A47
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:23 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id m76so9558716qke.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9o31eTNo5jewZMssyMhreBE99fTk9fWfix+IMNCftfM=;
        b=NUt98kIUoRedTYZR/hOWzj22LFXiaz89Di0iPSIbMugj22ZhE8V1wCasM5/hoh7dPD
         C4/8TMNmLkiJHOEZu7wim37d7s4b7MBJALayHmiuCVuddnXQqouHob4rm9wGJN2uLrMF
         Qa2rJ99RqjJChfp/LcuyZd7zA6PVh7sXRxjAjVC4RgHlgyAtcdkgc+BHCbtIshsYKqfF
         esnotmCO4mwSAq6WxLSxdyea39mHCauvAxQHiZhbXwuRX2RZebtE9G1d1BCqhTGtDpFg
         fmYMbFPks+GOqZe2KGAdUou1Nhk1bKImRT1+0LGGrEbmGHePM1zvytQMBQwTyQ84CWyv
         X9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9o31eTNo5jewZMssyMhreBE99fTk9fWfix+IMNCftfM=;
        b=LigpCR4nkYdiyLeWVayz4/alxt/m5A2opJqxV2Qy3BLeGktdVfX88ZMjfjoKWkvdgC
         08S7EmDW84wg3VjDBiW6DS/8g8TNtPdpScVRa57ilO+mEyNnipKn2fuY8CNrucDvt0oS
         mYoznofcgUcY84V5QNwmvPKzRfBsjXhFCvJghBP5L3SbpcLieOV0Ax9dvf5ip7rnxSBd
         eRpksGQBMZTxboJYOZwm+kagQ/oI2KkuC4xuqBYCjfPQaHWJ09nKb7jvW/9zFp56LNyE
         0N6dhqL/hQfd7pqh7nv2X1p5151pz9qs1NEO6QfdoQp+JPXOfOIYZizYcoe41d73vplO
         SbUA==
X-Gm-Message-State: AOAM533TadfEADJA39MHeTHmjghlHwXLxmvZsBfRmC7/nzfZ4ZkU+oYd
        OA/IqzxW9S2LnponchLcmNuc/gDaBG4i8Cw=
X-Google-Smtp-Source: ABdhPJzGgcfrOtRRkn0D0fR68l6T+z1eiCuDzxjSYY3YtIjfU62XgKotfm6cRt5W5QS4SAGVLKsSs5dj3i1L29U=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:4346:: with SMTP id
 q6mr19199492qvs.37.1605924202910; Fri, 20 Nov 2020 18:03:22 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:30 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-16-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 15/17] efi: Update implementation of add_links() to create
 fwnode links
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The semantics of add_links() has changed from creating device link
between devices to creating fwnode links between fwnodes. So, update the
implementation of add_links() to match the new semantics.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/firmware/efi/efi-init.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 65bb97c391b0..c0c3d4c3837a 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -320,7 +320,6 @@ static int efifb_add_links(struct fwnode_handle *fwnode,
 			   struct device *dev)
 {
 	struct device_node *sup_np;
-	struct device *sup_dev;
 
 	sup_np = find_pci_overlap_node();
 
@@ -331,27 +330,9 @@ static int efifb_add_links(struct fwnode_handle *fwnode,
 	if (!sup_np)
 		return 0;
 
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
 	of_node_put(sup_np);
 
-	/*
-	 * Return -ENODEV if the PCI graphics controller device hasn't been
-	 * registered yet.  This ensures that efifb isn't allowed to probe
-	 * and this function is retried again when new devices are
-	 * registered.
-	 */
-	if (!sup_dev)
-		return -ENODEV;
-
-	/*
-	 * If this fails, retrying this function at a later point won't
-	 * change anything. So, don't return an error after this.
-	 */
-	if (!device_link_add(dev, sup_dev, fw_devlink_get_flags()))
-		dev_warn(dev, "device_link_add() failed\n");
-
-	put_device(sup_dev);
-
 	return 0;
 }
 
-- 
2.29.2.454.gaff20da3a2-goog

