Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82940E49C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbhIPREv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 13:04:51 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53904
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348301AbhIPRC0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:26 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27F403F30E
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811665;
        bh=lLXS8SFA70byjSU3I64mTO8msYqwn7AgM4mAM+qQNUI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EiMANJGyqPqOICENXpfb8BGcJBgTi/NtaTQuguWhBiYwdhEr2aOMQHiA64vc6mHAE
         Ztdp6nBAo4pkjAOn51dKmur4WFYTFvElcVeTMI91gBImmJEq5dVUH+PVvdgyWzYiWu
         Mo8oKHT0nKx46XoiQoDQboqBbfRS0rXYFW1x/7czyk6H70mZ4R396His+OMSI4uCqZ
         pV+Y0Yi7EiZvuA4JNGLKi9fG39Woh+eXAW4wFMBX9R0FSQfA2Yj2DB6SivLTBAKNr8
         knx1sY6g7IHrNiGG+IoY5laC0tjoy6olayFlDIKVclp6UnbJYl3eLcBL6wgGDtKDrY
         o05R0OZwSxY5Q==
Received: by mail-wm1-f72.google.com with SMTP id g130-20020a1c2088000000b00308ecd761e8so515008wmg.2
        for <linux-acpi@vger.kernel.org>; Thu, 16 Sep 2021 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLXS8SFA70byjSU3I64mTO8msYqwn7AgM4mAM+qQNUI=;
        b=qqfzE41UNS3mBcjNOokmvtFSgjdUqMpkzNi/lWjjloiw6Ks2Ej3N3UfiaKItjRt/Tj
         TZbrIrihFZYDimajzVSBP0YQs9Zb+RFbCDm7CDxm8hkYH1UtZvFnHDf0/0YHK6TL2f0g
         VoN5btZlVhCt2kGcVjRZmkdduEDDRE8GBOfgBGXiKRUufTZBX02GPqxSClM4GbIl/cqd
         BXen37BnF2WoOLBxsDUcKAA541CGt9h0HNYHDbymu5ajtDHO1Jz7UmUjgtQBCISTCuMS
         VYzxeQ2DgoWHq74Gt+8rJdvezvgiCPjrZeCljWc+6oIH61WpzdJzSQ0Z3MS/YjH2jV5P
         OqAQ==
X-Gm-Message-State: AOAM533VkClfhz0kGCOfINyFEsEzI/3mlafaZ/V7Vk2Z1FJ0VBNuBoA3
        rZMGrLRTPmT+HkArXF4nn2Kv6QSKzO9Y9vhh/lRpIQ0UCpIyg3OSHj7YT8LUJUjitOyb3gH/CU0
        WghfwQXvKl6Xql4cOo1bTEY/R9SaYnzRmyHhK7uI=
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr10586911wmj.184.1631811664919;
        Thu, 16 Sep 2021 10:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt5lXb+YNan5B6bORK/XGxU+ZwX6sYN8W5zZeYQ3pwinhzCdxezQJk1xFkFHMOVrBMZRQ8NQ==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr10586873wmj.184.1631811664581;
        Thu, 16 Sep 2021 10:01:04 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q7sm4062646wrr.10.2021.09.16.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:01:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] acpi: pnp: remove duplicated BRI0A49 and BDP3336 entries
Date:   Thu, 16 Sep 2021 19:00:54 +0200
Message-Id: <20210916170054.136790-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
References: <20210916170054.136790-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

BRI0A49 and BDP3336 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/acpi/acpi_pnp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 8f2dc176bb41..ffdcfcd4a10d 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -156,8 +156,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	{"BRI0A49"},		/* Boca Complete Ofc Communicator 14.4 Data-FAX */
 	{"BRI1400"},		/* Boca Research 33,600 ACF Modem */
 	{"BRI3400"},		/* Boca 33.6 Kbps Internal FD34FSVD */
-	{"BRI0A49"},		/* Boca 33.6 Kbps Internal FD34FSVD */
-	{"BDP3336"},		/* Best Data Products Inc. Smart One 336F PnP Modem */
 	{"CPI4050"},		/* Computer Peripherals Inc. EuroViVa CommCenter-33.6 SP PnP */
 	{"CTL3001"},		/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
 	{"CTL3011"},		/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
-- 
2.30.2

