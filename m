Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC629E239A
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 22:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405131AbfJWUCl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Oct 2019 16:02:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUCl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2019 16:02:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so13588331pfo.4;
        Wed, 23 Oct 2019 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+uaR80mWxyEyufNFdwT5uU4rIjXURMixrRxXLGkFjQ=;
        b=Kd4I7/+T96ZcdbGqu9kwHt2mNR2SK6++Jywk+f9ipxuZ5XE+r4S+MKHXYekPYzHUny
         lQ4IZ+9lhaTeusxu4XAkm3pJD3DDA4MVdy8AzdPTb8+hX3izl/XsYOwYfmvhjSCIxubm
         wcjmU1pMvpLlaJ1M/3LBMzWksN81+rrugzLyRvNSSZ8aXjoltWGJNPX+f6Kewmr6yBHF
         tMjir14lsijueio2Fm/Y4cjZJt0J0T8ZJoO4SNpqX4nGN6V4jl0qFh20HZyxaR+uHmzB
         IX8b1VKJyXCrpwxgvwa9D7AqSgi3mkshmrsgHjpM9eTCp9wYYZanWjNIeL1etMhuZxWc
         8qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+uaR80mWxyEyufNFdwT5uU4rIjXURMixrRxXLGkFjQ=;
        b=ZAMTbWuktKOfwD91fBW8cjVEfw0DPbXqY5CYbpcdHZf9p8QjSwgmL0Y8Sy+NMyL4XV
         qNZbLO/eDXkVag18FLM4CTMS3c00vvDClhJoaChfvBXn6oGJl8dBTZiKHkVa3odsK77z
         E8g6skHQXkjFoxZ6ngSRzFJHPicjTVCf+LjTM0BeAZc6FZ/lizEOFMLyqZkn2SjLNQpb
         f7K/Hmn6kJtXVDewKyOrKhfSdbU64xz8xJ5lSu8XDaGzu6k5AeLzJdWemfO/xvmgpGUD
         w8ZolznMv2itKMl7cjjz7YwuCRpoaLH69nsWsiQTPCmEI5fYlbhrouWOOuFGYoDnMcxy
         fK8Q==
X-Gm-Message-State: APjAAAXbD9CQX5q8fuEVeZ1Kl0j3UmXGOv/jAOcFNGpFCdqs5t5DvKYo
        K/3n7MQxXz0NeAogcYkq9TE=
X-Google-Smtp-Source: APXvYqzk2kFSSSIPZCcAa9BCC65JFT24sxV3J3C8eiGVaYoIhDM22tDEcFoBcHCaftifD9Z4ORTCxg==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr2222496pjb.59.1571860960237;
        Wed, 23 Oct 2019 13:02:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 01/15] software node: remove DEV_PROP_MAX
Date:   Wed, 23 Oct 2019 13:02:19 -0700
Message-Id: <20191023200233.86616-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This definition is not used anywhere, let's remove it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 054661109661..0a075fbde57e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,7 +22,6 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
-	DEV_PROP_MAX,
 };
 
 enum dev_dma_attr {
-- 
2.23.0.866.gb869b98d4c-goog

