Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268452BBC1B
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 03:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgKUCD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 21:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgKUCC7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6FC0613CF
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t10so8348928pfh.19
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u8gSY0xV7Hxd2w8NGW6IzppBe4J1ijRyucJg3LQF0Gk=;
        b=fsbK5xxw4z7i23FSKugbrasJEIXN13Q4zN4isokluNuL4HjEO/jGHpCycjM7g9sfqR
         +kbOqa7qcSGga0Lm/F27nYxTNhPX4fRgh4Mf9+oYz6aUhraA4s7J5QNNMCxQsLKJfiu6
         hO9xCcF+bjceWP/4mkj62eK+d2GhPUnH8ipvjoF5lXH5cwi6X4Wyh+5rcJdkI2Y7Mg6U
         iT6tK3+H9NRURvDqYLmMIA70OMrl2Yj+fQCQc8tKeIPW+uVGa3W2KjLifbeHcVbYlj5y
         Q04w/t2ewdvVIWyUrX6OqLnatW7MndjTFeg7RNiUGjOroBN0Dv6izRyJdeVw3DlHXFza
         a27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8gSY0xV7Hxd2w8NGW6IzppBe4J1ijRyucJg3LQF0Gk=;
        b=LO2Xnxjxh6cgHmHFE5SyhaIE16JyxwBKsxQxGySK+U4wnnADgW6YZtvcZuLWlYsJnS
         /niegQMfySoJlhACKnXk9fRBVP2UV4g5B9yYjMdSfZW5oxcKiyBOKd1EDCM0wC0sqQNt
         DHtDATmi/U5xAcLHN+ZxY50wKeFDjvvN7tBzLuoymuCKhw/eECVaFLV4faOnv2I9wQKr
         4Y2L1CxsQ83PEVoZG/KTZNiMMznGLLZ8wwAyj0gcZwnEidlM5Rhq83rhTGUsb9zK2eW/
         zyy6CBRyQZ+NxSBuqJ/4JS+tVYiK2jKRF6MgPS2JPIgzXTbLVIS3mAj93tbrFRKyolAM
         z+RA==
X-Gm-Message-State: AOAM532w3XrZoiz0o3eoc/ALQC57MrXynSMFL4tT/oHU7mngHAf3TX4i
        Co/sSglL/QFyfRHzZYkhq1J4ofOXaFgW+JE=
X-Google-Smtp-Source: ABdhPJzP83DwhORfMb+bJuQz5UmJs3XebCnI6uLqfDOyEgb2ymxIPPeS7NMxGqPYiMO5s4yUrfepUAr2i5NMiTs=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a17:90a:f28e:: with SMTP id
 fs14mr6235679pjb.91.1605924177080; Fri, 20 Nov 2020 18:02:57 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:20 -0800
In-Reply-To: <20201121020232.908850-1-saravanak@google.com>
Message-Id: <20201121020232.908850-6-saravanak@google.com>
Mime-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 05/17] Revert "of: platform: Batch fwnode parsing when
 adding all top level devices"
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

This reverts commit 93d2e4322aa74c1ad1e8c2160608eb9a960d69ff.

The fw_devlink_pause/resume() optimization attempt is getting replaced
with a much more robust optimization by the end of this series. So, stop
using those APIs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..79bd5f5a1bf1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,9 +538,7 @@ static int __init of_platform_default_populate_init(void)
 	}
 
 	/* Populate everything else. */
-	fw_devlink_pause();
 	of_platform_default_populate(NULL, NULL, NULL);
-	fw_devlink_resume();
 
 	return 0;
 }
-- 
2.29.2.454.gaff20da3a2-goog

