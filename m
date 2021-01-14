Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A02F5B77
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 08:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbhANHmP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 02:42:15 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55133 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbhANHmO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 02:42:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id A2DA3132C;
        Thu, 14 Jan 2021 02:34:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Jan 2021 02:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=pl/fwFs3liZoW
        1v6PYB/hJz7Z5at8pyDDKPnWlYHs1U=; b=Vjx7eaOy1vJv654LTe33cK7wrK7ki
        cxqh1sckvpLPILenpW40fU96MM0i5tqiJWOvH6wZXPHeGIoK89GxBsJfFvxtbrWa
        u/ZViEotgUSHRpcx4fX9RcaHRQTPTuDUufSbW8SGpTmpB6P+yIXVya8uaCI+DsCk
        RI++t9XnAEGt60pubaZCL9axdNvaoFT51FE9VGCyhqKbZqD5ybJhKKrY7kyL0EBL
        k/of1r1lwdAykELA10rhhR56fnN7yaBi2KVfKIeviIlcAGhm7+pshE92rUvYiP8G
        Tsffk34iueSsuprrt5lwKUub3OIRcirU65PsLjlNzTp2JSIfBOEDTO5uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=pl/fwFs3liZoW1v6PYB/hJz7Z5at8pyDDKPnWlYHs1U=; b=m4+3rHxg
        q3fjYVSNPIXoHSYd+cwQwAxEnlVDa8Ad/BKqihP3amQStSTsrRk+KAuySHMfms1N
        WkSocEcHJgZUo3nRL5ODSiVTzbq2XTst3iIlXYsDPMPf6lVPUtLNGK/2iBoEaHsE
        TQ28Ikln1/iJnecSsEf1vSzCpYns702p1gs/zbfThdjDqgdu1dxEgX3vQ3IDUDe0
        kl/7N6fyhgX3h4WLV5kPGd7TJzsPEdOuDgl+mJV37SmLXF3KfNEpJ2imTHji3EhL
        HXwxf7MBpZMejkZysOeWZb/EzaGq0KWNqxlLpF76gjKPthv4hnBl8n9B7KgcvaHq
        Y/P2NaKr5AFbhg==
X-ME-Sender: <xms:EPT_X7xWW_bwgpUsq3e8NmjB3_DQm1sQhl108BG0lG25LisRa3KCKg>
    <xme:EPT_XzTyFjpvOdoKReS-CfLLFLGBtAUuX2m3TJiS4Y30FjXrsCqWqe0VJBaSJyPYA
    WsKaww09lUhSSweS30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeehgfelvdeugeetheekge
    dvgeehhfektdetteelhfefkeeuudekvedtteffteegkeenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecukfhppeduudeirddvvdekrdekgedrvdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhih
    ghhorghtrdgtohhm
X-ME-Proxy: <xmx:EPT_X1UwsLDzCBhTqU30tesIwV7Nypc-KA8puv0UYfMrc_6sN4AwWg>
    <xmx:EPT_X1hesA8pFRyhr1X1kDTMPPIDongoAFtWjPi8-kp06nDSh4u2aA>
    <xmx:EPT_X9D_PqjHQH1Opg2dPoYTRYrnIo6RK3WqOPAUZoneGLNVeMU1Rw>
    <xmx:EPT_XwM33LbnoOsinfmBgEkrYfgXliXQaWxTZFflMD0TL54749TfdvsuZKI>
Received: from strike.U-LINK.com (unknown [116.228.84.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD72D240064;
        Thu, 14 Jan 2021 02:34:38 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, hdegoede@redhat.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH RESEND 1/2] ACPI: platform-profile: Drop const qualifier for cur_profile
Date:   Thu, 14 Jan 2021 15:34:28 +0800
Message-Id: <20210114073429.176462-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
References: <20210114073429.176462-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All planned uses of cur_profile have their platform_profile_handler
defined as const, so just drop const qualifier here to prevent build
error.

Link: https://lore.kernel.org/linux-acpi/5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com/
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/acpi/platform_profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 91be50a32cc8..9dddf44b43d4 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,7 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static const struct platform_profile_handler *cur_profile;
+static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
-- 
2.30.0

