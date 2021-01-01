Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8DD2E83C2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Jan 2021 13:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAAM5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Jan 2021 07:57:40 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36673 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbhAAM5j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2021 07:57:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 25D7758041A;
        Fri,  1 Jan 2021 07:56:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Jan 2021 07:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=/ETWZ4/0vUN6q
        k8OTyPL4Ov6POGsGEMJ3pj3b0rxw10=; b=TzeRUmDFW/zy7JbeS+HW2hWzgUy81
        wfywMNo5H9l1dsQUENRD9qIm81s/RMFicByO7A6euV3ARAucYouC/C6Z1gPtrWVq
        Mr2e0GzTAka4iVEtq+ptrtTACXb4vSDttkGUylVKPuC4A9DgyO3HmoJ8jej0ZNW7
        6uPgFcLZtK26wKC4ARjT5T7w+LW7uFVRdRKojgUsVoSAtuwyFRgpsFdWDCE2cCVM
        wEibcYqyLtZKt2/YhFFwiHq7TapdjfZ8/JYco+X18UJdv/+CEJbrOurjliewc+zn
        Heo51y4fNEPXsaqccFW0LljVEXNVV4AglZGsR1eGYSme2RUvE/AcBH2dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/ETWZ4/0vUN6qk8OTyPL4Ov6POGsGEMJ3pj3b0rxw10=; b=bmGfekQ7
        fH7/f/ZBCeXR+qyhbVLLcpzXOfiEtxeCDqTZjVklRTc0v1PwYQy4zd4TB9sQ/PEV
        yBfNntLk7AV3taiP4IvIwy9Yd197sSI4fmvWEd2YtsbrlALtxhNumKZLJvWp4m0b
        ybvs8C/t1ZcOd91qtyfaxAEnclntt+y9SwZ489hjeQViAAbeZybiNiPCE17rdoI9
        ZFmtjNXP5EfTCgh2W1skwpIYTJwLcETFcOfCEEU/3jpZtD5Q6IAcUUd5ZRBhwjPx
        SRA4puBwvZ9J9E9vvO0ZJ/G24uB9EaRFv8fmxnxnrRsG4Y8PysQAQI0UpZTa2l3H
        zjbb0CXqh0Cl+A==
X-ME-Sender: <xms:FBzvX3L3Oy5ejcgYwz88fVFAOgIF0TaTeNuECKi1Mp8NJ-kqKIjGfw>
    <xme:FBzvX7Lj5tB4iuAmznZS_ddrg41jRalQfH5zXuAtQDUKFsNdHtM6ev7TSvLLnru0x
    dwWDbtljnY7po2l4cc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddvjedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeeihffgteelkeelffdukedtheevudejvdegkeekjeefhffhhfet
    udetgfdtffeunecukfhppeeitddrudejjedrudekledrudejudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FBzvX_s2WZ7I1pEoK55Oudq-8medDzzEy-ihlmk6UNvXSj-t8CwqNw>
    <xmx:FBzvXwZXqTFvcAgedDZ9BPG_42_9BMvlAk7aaodFsin6ghIuZpi-yg>
    <xmx:FBzvX-Y1FfO1QwNRPCy7cy43bFGq_fQ0DJLjkszh3Gz0bHrkZcjzuA>
    <xmx:FBzvXzMdPsA5yEj6ik4EjIwah8v9GsEf1ae6gVXCz-LgkXsAbw0xYA>
Received: from strike.202.net.flygoat.com (unknown [60.177.189.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 457CC240057;
        Fri,  1 Jan 2021 07:56:46 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: platform-profile: Introduce data parameter to handler
Date:   Fri,  1 Jan 2021 20:56:25 +0800
Message-Id: <20210101125629.20974-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a data parameter to handler callbacks to avoid having
global variables everywhere.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/acpi/platform_profile.c  | 4 ++--
 include/linux/platform_profile.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 91be50a32cc8..60072f6e032d 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -64,7 +64,7 @@ static ssize_t platform_profile_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	err = cur_profile->profile_get(&profile);
+	err = cur_profile->profile_get(cur_profile->data, &profile);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
@@ -104,7 +104,7 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	err = cur_profile->profile_set(i);
+	err = cur_profile->profile_set(cur_profile->data, i);
 	mutex_unlock(&profile_lock);
 	if (err)
 		return err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 3623d7108421..272faf55875d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,9 +27,10 @@ enum platform_profile_option {
 };
 
 struct platform_profile_handler {
+	void *data;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
-	int (*profile_get)(enum platform_profile_option *profile);
-	int (*profile_set)(enum platform_profile_option profile);
+	int (*profile_get)(void *data, enum platform_profile_option *profile);
+	int (*profile_set)(void *data, enum platform_profile_option profile);
 };
 
 int platform_profile_register(const struct platform_profile_handler *pprof);
-- 
2.30.0

