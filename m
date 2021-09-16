Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38C40E58C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhIPRMc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 13:12:32 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59516
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345171AbhIPRK3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 13:10:29 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 381E1402CD
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631812148;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Iooevi3UgMJ+mkq676NMoJgjiVvtG0YQy+kX8NGAWYvMHVHPpNelUZaK0d0XFUHAA
         P2ToA54XP3ak9kiytO6d9CELRmMyfoDH4bNlmMFctM5Ij/4/hRqBgxP2mL86+5mhKd
         brJ/Jtp6sY6JNaQCW8nZ3iOjaeyhsRhK2hYRLjgNPA01JosPHbirobHVJSkpfqAMRe
         ABNlNGRjAGse3og45yS34fhwA0A69GhC++yEbvBXeF6DH/8r6tXvFM3N2fJZ4tJ2E+
         oCczyH38JeQur4iEfekno82Q9DmzZsvepk4Nwf4tdibeou5EPsEHP46Tv0Xiq4lSoG
         7D7uDxyCIU4aA==
Received: by mail-wm1-f72.google.com with SMTP id g70-20020a1c2049000000b00303d06c20b2so3784184wmg.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        b=D8QHcPzWWENuUw+GCSZ92MXbitVTs489jHpe1Qp8srnE3OKO6TUMebMlkhIWRGmZzQ
         sUK0GntVDfMo+/zKgZzQh1lDM5/oMxy2K1+qfikCEPh6Q0zS9Jh+hnZ8Y7HGH3KEuyp+
         qCSX41rbSt58Zs8jfs+zSJFNqLwkq9QwlXWOAmQiX4F3/JODz8bUWfWrNx5xvmyxcCGG
         s0u0pYMYbFZDnt/PS+2XcLhHDU0kJOzqjpr5KR6+yvnNZnYr+gAXtxJt9wxnTJlRX3CH
         FOJW2iREsfuGc7B25kEhx2wY21l14AShC3ycvOgGuUZ34rQZpJukBePVDCmFsqe/iHqi
         EY2g==
X-Gm-Message-State: AOAM530rY8y6pu8s5y3fb555YATZy/H46lw1ZGsJi4PywNFJ31bdFgVq
        uM1d+xyaR+NldMBqyHx5lKAuCvjrYpLzTovJBznAgtqJXQ9IxKYsdmB0ICsI0bMWTK7qixMJal/
        JC7Fd7S7e/mv/gDVaaV8CZSrtVpTmTt9MWElL3Ks=
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116421wme.71.1631812146008;
        Thu, 16 Sep 2021 10:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPp03RDoAih9s3NW/qGubj3h1EcnVLf9/Ph3lRs8Ac+5xs5w5VZJCzJ/TDFN0K5bf63k0ndA==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116411wme.71.1631812145892;
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id f20sm7893839wmb.32.2021.09.16.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] serial: 8250: remove duplicated BRI0A49 and BDP3336 entries
Date:   Thu, 16 Sep 2021 19:08:59 +0200
Message-Id: <20210916170859.138813-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BRI0A49 and BDP3336 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 98e5ee4d0d08..1974bbadc975 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -56,10 +56,6 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"BRI1400",		0	},
 	/* Boca 33.6 Kbps Internal FD34FSVD */
 	{	"BRI3400",		0	},
-	/* Boca 33.6 Kbps Internal FD34FSVD */
-	{	"BRI0A49",		0	},
-	/* Best Data Products Inc. Smart One 336F PnP Modem */
-	{	"BDP3336",		0	},
 	/* Computer Peripherals Inc */
 	/* EuroViVa CommCenter-33.6 SP PnP */
 	{	"CPI4050",		0	},
-- 
2.30.2

