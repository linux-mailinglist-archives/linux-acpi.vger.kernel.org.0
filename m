Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4CE2EABAF
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 14:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbhAENQ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 08:16:26 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33801 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbhAENQZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2021 08:16:25 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 77ADA5803E1;
        Tue,  5 Jan 2021 08:15:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Jan 2021 08:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ETwu6CPGMYAhT
        xVZhEromat1wLEp52aBdndvKeYkzEA=; b=1BWqdd1cDOIRw4ZZynCPGZvO//5Vb
        mlr1o+fHPg8evYSzUqkSErwahM9zIKJv1JBXA0V17owU4t3+txl2C8RUxHG4+xV0
        HFDhHDLD3NvhPkvAaRpOXrJ1effVE1DKobEL49XItkz3QD053t3S3t4w4tV5dSlM
        gZ4mQs3bStXQb1SWMtgrfvnr7NPWZJhkbelofwaQrAQ2it2+/0TdYI+XnYdUxlgh
        rn5H3G1ld/AKYE7MRaTq24F+yFb70FULgZQQNQe0dURCt6+20a2lp4h4QPAXO6wY
        pMVVmn7CgTwemA5Y4WmRINb79elJ6mxKlhG/Zsmj1o1mxWllmO5G4IqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ETwu6CPGMYAhTxVZhEromat1wLEp52aBdndvKeYkzEA=; b=KpDmntg+
        Cq/UQGbIsVASQgszF7mZTfayxfXdiN20f6hDL1vwEDJivC41563O92CMZ/bEf0hn
        KwHLsbRpd5ltzOx4dMrtXJMxaGbg8orctj4Wx6fvkZWlLQ8tBT8N4Jp0HLifYM49
        Pa/rt06exVU3JPr812R2BALHBrFP9IFaGZAUWbkeYPx3qdir79dWoN7Mrn0Cl0q8
        Y5HcyYT+eu5wO8I6P4SgtJl5fiPJhyzYkSW/KcBaQ/kmri+gq0NJLP4BcVkxblCs
        3wDM/EGh2JWIf/L1llxBHidI/e14Izmd2uDx5Yvoa8zD/HPEI0cQls1bl078qG7u
        K3dmfrzWpTIR4A==
X-ME-Sender: <xms:emb0X0C-I6ukmwV4SkB2HroEEmOPtFlwP4kzZtmozQt8kxvwQBwePA>
    <xme:emb0X4jsR1pm6IGCDxRvvnrBKYWLSI6YWKdbrUKUOx-kgMbCnGypwas1r853nA7vq
    AzBFzls-gbc_6axSuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeeihffgteelkeelffdukedtheevudejvdegkeekjeefhffhhfet
    udetgfdtffeunecukfhppedutddurdekgedrudekrddvudeknecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:emb0Xw9n93TtsISlCni8UtF06yJKNgO8-2w9enFT16ddx43GA5zk6w>
    <xmx:emb0X89Q57ir1J-JNdGppg1A5MdaYpCO91o5Ib-9-C2sLW1xUxkQTA>
    <xmx:emb0XxBPlk_ViiO3HVv4ufRvdaqgHzFF2N1VT02niu7OiBlwzpqelw>
    <xmx:e2b0X9N3eOdriRO1ySW9v4W5NHfBKUjmUSsvLFah8abhPw2b98yRZg>
Received: from localhost.localdomain (unknown [101.84.18.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA3FF24005B;
        Tue,  5 Jan 2021 08:15:31 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: platform-profile: Introduce object pointers to callbacks
Date:   Tue,  5 Jan 2021 21:14:42 +0800
Message-Id: <20210105131447.38036-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
References: <20210105131447.38036-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a object pointer to handler callbacks to avoid having
global variables everywhere.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 91be50a32cc8..bb4d7b0fe2ac 100644
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

