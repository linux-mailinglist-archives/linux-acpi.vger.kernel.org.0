Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1A2DFDE2
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 17:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgLUQEi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 11:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLUQEi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 11:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608566592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vy2TADSbUuu9/F3d6TvrBXR8l6iJyutu/ClaiwDiIeo=;
        b=POy1YgJrkkszIbWJvt2JBkqpW7+ZdDhlEVSwsfjmkLudZPrpO2ShrkXemQjQSN4odWQ/Vt
        GmPC6MTF17QjkyahdLTN18fr6kXdJrxergvcOlf6OcAC/oWWfj8IuEM2sFkkusBNm/HV/g
        lHvcpJSa2TlLKznT/mUyPQXsRk9EUhE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-d8qOG8rpNhqxopOjEA737Q-1; Mon, 21 Dec 2020 11:03:08 -0500
X-MC-Unique: d8qOG8rpNhqxopOjEA737Q-1
Received: by mail-ot1-f70.google.com with SMTP id y14so5220202oto.21
        for <linux-acpi@vger.kernel.org>; Mon, 21 Dec 2020 08:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy2TADSbUuu9/F3d6TvrBXR8l6iJyutu/ClaiwDiIeo=;
        b=jECF8mZDUDcq172vuMKs5bzuDLqWCmeR0vcbaib4SYJo5GrVtAXSjQ8u1qrKO0dRF8
         PIUmj3eUKdAX1Ps1wAMN2oLoVx2A5eklyrIk2F1rwq6sfZBECJ7A8/pphWV/3rd77GX5
         fcKXZvZPu4Y/4aHUOj8eJoA1uImJlCa7f7Ghl3WoloxI/PltZWC4DyiEXLGQjFPtAUhs
         xRCe52djLqvRz3Pap6Qk9RhzsWmhcatdFJERbKiH/aTjEyxQH0yJ8XmCCd7TH/q/iMXu
         +QB5SY+SdgnPm5P68NLciQHqX2q7Wwp69RA3L42LGT0H86mC63ZlPqGPrAF+ylb4kUdT
         xmHQ==
X-Gm-Message-State: AOAM530vbq1cmHGQ7OQaYD8HnNnZOnJora6MhMBS99TD12S1dKbY04Iy
        WKM6jV6lH0ilqPJRnjH4CS+rhJSFRwkLDwslJPt0mIK+fUS6XN7EaQjhPeeoly1/CQm/EOaR1xZ
        +hMthzrUhVni5Oe3qNJttRA==
X-Received: by 2002:a54:448f:: with SMTP id v15mr11683559oiv.106.1608566587620;
        Mon, 21 Dec 2020 08:03:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi/FAKLZdRWZAD+hmgdadkXialWoTax/uzPy2j7itrqWN/sCzu+29sZhmCqHiBE43NH8WDLQ==
X-Received: by 2002:a54:448f:: with SMTP id v15mr11683550oiv.106.1608566587519;
        Mon, 21 Dec 2020 08:03:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 126sm1791340oop.30.2020.12.21.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:03:06 -0800 (PST)
From:   trix@redhat.com
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PNP: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:03:02 -0800
Message-Id: <20201221160302.3752887-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pnp/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 187e4a1175b0..602c46893e83 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -33,6 +33,7 @@ struct pnp_info_buffer {
 
 typedef struct pnp_info_buffer pnp_info_buffer_t;
 
+__printf(2, 3)
 static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt, ...)
 {
 	va_list args;
-- 
2.27.0

