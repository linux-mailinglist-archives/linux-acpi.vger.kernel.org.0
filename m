Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920892A7177
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 00:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgKDXYP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbgKDXYK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:10 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E98C0613CF
        for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:10 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d41so13729015qvc.23
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mDVvKrGHCP/3KBqD6Y+81Awc8s23VoJcXWEM4lmGqQk=;
        b=UrcXOwPS8nM7/ikskpgkXlxdwbC7fRg65vxlDw6UBrphzbOZujaNWx+XnNzrdvfUG/
         /zmaPWK7O35YUG+60QYL1UALaOrJ6CfR6nAGsV2hplG8Yf26liCR0ccZzdSHdbBupXXJ
         rY2CqHrp20pwo/CTtzIxcuqLuKGrA14ZoXu6KCts9HWKDuYEOTfNM63I0dPMDajm9Wzp
         jWtQomAP9PBmL8GgNtu0xnEm8BEEHQKYoQ6NMZMN7wSfQLGLJ+qokqu6ep05laZoVOK9
         pgZxS63+uVe2nNyTrMSxZTqlRYb3DosJhQyFFGylNr7KUnAU0tLAXJQV4z2s8Hl7PYzA
         Pi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDVvKrGHCP/3KBqD6Y+81Awc8s23VoJcXWEM4lmGqQk=;
        b=DPdPYQU6Y+C/qYZjNY6Aklv1SfRsCgjNIf/7CqGLtLUKoV6eDv37bxvMsfRVw6ZRs/
         orYjlZ9uTDmVEJcVo8i3oksUA+/9Mb+lLOm3awoVqjBwQgdbkmVVhaGcZ13syjruLNHJ
         YKpJK/z/awEOxlEii48EKsg8SEM0tkajNhEJn9zmHImDN/6ndR+tEdlPpPh+ODa7K0b0
         X/WuHuVVCX7lylYra7AD9rVxXr64Mz733XmG0ZxkO60T0WJYr0RgyZ687D0zn16179jn
         1+2HepvljpnTkxKwUKtz78SQio0dxy9fo7WeSwS1TgosuyoVS3WYxTh+1wd6X6zq4mnW
         sqWg==
X-Gm-Message-State: AOAM532stUiksuOTGx8SPBTnnay5XIBMHrVxU93sZVyX/twYZwuHMKmY
        n/oNhe8v4JC2S46UdABGpz2hiOrHLGMhxnQ=
X-Google-Smtp-Source: ABdhPJznoHrAzCZtFLgjYhiJnzq1jZvYLPBro0eYGGwHHgz+egObOJnpHGOf9HuWhTEgl/sUfC0vy14swG3g6NM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:ad4:4205:: with SMTP id
 k5mr310786qvp.10.1604532249490; Wed, 04 Nov 2020 15:24:09 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:41 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-5-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 04/18] Revert "driver core: Remove check in driver_deferred_probe_force_trigger()"
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

This reverts commit fefcfc968723caf93318613a08e1f3ad07a6154f.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 008724f8edf1..ec67b5ffa06d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -172,6 +172,9 @@ static void driver_deferred_probe_trigger(void)
 
 void driver_deferred_probe_force_trigger(void)
 {
+	if (!driver_deferred_probe_enable)
+		return;
+
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.29.1.341.ge80a0c044ae-goog

