Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B742F5B79
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 08:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhANHmP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 02:42:15 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:46995 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbhANHmO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 02:42:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 30BF2133C;
        Thu, 14 Jan 2021 02:34:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=y9iRB6bWqyUOw
        TqFryU9bKwjbnx+WsNsQUdiHEf3u80=; b=yuOR9eeGEYszXoXcjxIOQ5wU5/gxW
        oAf1xKensHC9wRv5w7HYinK8QY1DqiozSUbTjTHE/WAAVewfPjRj4hXB6LvWXbTd
        zc89xW1IHFwUdKLYYovlsmjzZIiobwnfPeaPWotV3wb66wbsKpHd9sCywvy9yAYA
        PmQmj+BeXIGpvqnv9QYMDF064fElYp1GslkGE1ms79PEnAD9Gf4Cjm75SvUmbtqG
        LUV3Urc8qNo87QhO0GSwJmK1eP1Zqu/NDDpsrYZEUUZ/gHjocQXhpuOdYGucrSAY
        MIB/LueHOCAnldUJZHYVQrnORkIUTY1JMsq7a9iTB+kLzkpTu2UYWwGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=y9iRB6bWqyUOwTqFryU9bKwjbnx+WsNsQUdiHEf3u80=; b=PIirAcYc
        6F+ruUoVAvsfEtw/snDwaXFKkzvT3zliRgCCn8UIhx/ypEk+hOfBNCY4Vpc5KAaa
        ATGo4lrloRR5YQKIae4iPd4ojlBF6vqClnRNb243B62ow0/ZOMwu72XLpWYI1att
        6sUdLd6ICO0Mnedos3tz5N0Yy0KgaXqgisbTIjo4/By/ga6Gzu8XKuznCPq22ZBR
        YlCRcWy9xYXh8i3Nf6La19iEW9qQ7Yk3tb11wQVq4NQfJpWrKcW0P3eUvPWsBFBW
        VVHeQRj/1VDEOqCUT9AK/GGVXejLv1qAJ/qsBbf40TXVdSOwa5/ZSZ1PP7gRZ2e+
        /ncSQcjaVnXLsw==
X-ME-Sender: <xms:E_T_X01tPrPAt7Vl-QYkbAn7xfOQ0C8qeFlROl0DOUCYYYiB24erGg>
    <xme:E_T_X_HTuTiOjw2eO0oOaofwDJTBwaLN6CVgNGxXYpAigO6oYZ_r1eeVmCA1Vzzzm
    WjZQcH2z4se8lUppyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfelvdeugeetheekge
    dvgeehhfektdetteelhfefkeeuudekvedtteffteegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecukfhppeduudeirddvvdekrdekgedrvdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:E_T_X84bFnNy-mmJoTDC2xBcQz1dIPdDlXGL9X_JcENVv90DTCcB3w>
    <xmx:E_T_X91WMGir-JoUtrOStz0nYCD7agOYWgpzMLJtDD3stRoRmLAbUw>
    <xmx:E_T_X3FOn8B_P8f2Z4YIIwHrXhinqZgQ6X2FmtIofUV0ciCypyTwbw>
    <xmx:E_T_X8RYYQjcIebCVpMjgSjVudQVHuTKr_hOn02mZ-nAJNGXbv9k8PVYc1w>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B363240062;
        Thu, 14 Jan 2021 02:34:41 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, hdegoede@redhat.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH RESEND 2/2] ACPI: platform-profile: Introduce object pointers to callbacks
Date:   Thu, 14 Jan 2021 15:34:29 +0800
Message-Id: <20210114073429.176462-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
References: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a object pointer to handler callbacks to avoid having
global variables everywhere.

Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9dddf44b43d4..6398b40e6d31 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(&profile);
+	err = cur_profile->profile_get(cur_profile, &profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
@@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	err = cur_profile->profile_set(i);
+	err = cur_profile->profile_set(cur_profile, i);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 3623d7108421..43f4583b5259 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,8 +28,10 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(enum platform_profile_option *profile);
-	int (*profile_set)(enum platform_profile_option profile);
+	int (*profile_get)(struct platform_profile_handler *pprof,
+				enum platform_profile_option *profile);
+	int (*profile_set)(struct platform_profile_handler *pprof,
+				enum platform_profile_option profile);
 };
 
 int platform_profile_register(const struct platform_profile_handler *pprof);
-- 
2.30.0

