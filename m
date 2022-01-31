Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4824A483B
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiAaNdr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 08:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237819AbiAaNdo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643636024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VfFqvSMV9Otew6WwuduSbrALdReBxJUaJj+oMXEGVOY=;
        b=jENr9/180kLfwkhAPpOiL/D0c4pP4Q9sVwAXpM2veNjCxeUwnlPaDL2r2WElVkJlTKDRnG
        tIGVDDBupnkUkH4BAmWtm/yVlgHEizW26sQ3vizHHy4m4I2/ieEEAeZCHI0IsqE8oguSUN
        WgspDEF4YbEPrqIGSQ8PVx8oV2KeRFY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-H3JJtvK1Po2Le7PdrOivFg-1; Mon, 31 Jan 2022 08:33:43 -0500
X-MC-Unique: H3JJtvK1Po2Le7PdrOivFg-1
Received: by mail-qt1-f199.google.com with SMTP id c20-20020ac84e14000000b002d198444921so10218290qtw.23
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jan 2022 05:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfFqvSMV9Otew6WwuduSbrALdReBxJUaJj+oMXEGVOY=;
        b=0/v6EsawY4XfRTjcB6nDUXsnb5iONJDhmJ+2dCcn+iOv748QKklT0I+7RMQYmmlGj0
         krjtXPb1zqkgSxC1qz5fYerRbw9v+5rH5uRxAFfRv0WULmIKrXClzQvbYkKBQ6Mf5udW
         OmT2wzIq1GAGI7/ov5K1En//15b2nrAgLdq90aBQDpnswhhBISPLkuEsKcoWy4IY9db6
         RKMkPvWvZoezGyxEd7J1VrsXE+gWe29A6OSIO4dPppOu1EBZ8l44jsbVRy8QOnpK/osq
         8MG1xLJhEsDVYYjjZDyt718VrE9YVTwlA8tZVinboUkzDzgpNWCaMRBxIDyt9iiYHI+c
         DvbQ==
X-Gm-Message-State: AOAM533iBlYwvNvADt5kdNCrciNPD9LsYZhk1mSXPLRj8cIZCA4vjZ4n
        uej3K85r/Ghm32DKQqDSraJrcmsK0kYFbePCdHTe/y0OFEnDDilYtaASpQaS+xG+gnmCl2q6lOP
        ezSYbWFUKQYBUHGoqIWmzmA==
X-Received: by 2002:a05:620a:1792:: with SMTP id ay18mr13373131qkb.12.1643636022750;
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0RwA9z2nQfn12ZGFBT5t9iGfjKQ2Az19u0I4r0E5BKCJkPncDYJOi+4lmU54lStlau3WU/A==
X-Received: by 2002:a05:620a:1792:: with SMTP id ay18mr13373119qkb.12.1643636022563;
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u16sm2047274qtx.46.2022.01.31.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:33:42 -0800 (PST)
From:   trix@redhat.com
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPICA: cleanup double word in comment
Date:   Mon, 31 Jan 2022 05:33:37 -0800
Message-Id: <20220131133337.1556355-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'know'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/acpica/exfldio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index bdc7a30d1217c..b92605df3872c 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 #ifdef ACPI_UNDER_DEVELOPMENT
 	/*
 	 * If the Field access is any_acc, we can now compute the optimal
-	 * access (because we know know the length of the parent region)
+	 * access (because we know the length of the parent region)
 	 */
 	if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
 		if (ACPI_FAILURE(status)) {
-- 
2.26.3

