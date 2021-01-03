Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E022E8EF1
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 00:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbhACXOu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Jan 2021 18:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbhACXOT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2021 18:14:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FFC0617A3;
        Sun,  3 Jan 2021 15:13:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d13so29983231wrc.13;
        Sun, 03 Jan 2021 15:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/fN8j75cdvHWjP711I8fZ1KKscBeHrHUv8cZvUXbFg=;
        b=Q7te5DVPWPs0UBsnU1iefc00My6AErMnbEnJaShsMC41RC8Y4jZyebqvvmcN6DsOuB
         pnSi2YUOJnc2+B4H+fADfwF69GW9Kzl+aA8BwVJSj85dKyMfQA1jPB+9EqLotXPFGzU7
         kEMZI/bc9vHopmZ2cTcb1xZS9YnV8jA5hUxuZc6Mq9mAtA/XmIcgp5n2EeXGGKA1PYWi
         PZrFZ+jq6l0d0JWxvzElAMTwSo5DU7sV23SSXxutmjHsim3htMwSLpsVNam9bcjQY1c8
         Lx61HiGILyIem5KXcUAmy439yb4DuBm2mPDcTB0ezhuXw7E9xOLcn05R2nkRrO5iz9ll
         lkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/fN8j75cdvHWjP711I8fZ1KKscBeHrHUv8cZvUXbFg=;
        b=gPbMvuPB4r8UYapcFN1kFVshpQHcou4DEOM93LJRvicyjXzxNj3Nb8nkQzF8DwO+50
         upZxFagOHbjMUHOazNMr2D/FPo9q5DDB+CA62Rz/zyeie0pXANwWLwJdWp/luCUZwaVu
         DhgJhtVsPii3mfM+2iiwwz0udpl1MVT+a1IEXb1Mplv792RxX9eB5LXaweFuqCGN5u0k
         mSR9o9CbnacaJjjhkpZzzaQr0eF3vmpKLqCj2lCqYIh7oZ5y+r1FrR8pcTU7L7L5BLIP
         E5xiU7swQH8F3KARYMG+VJli/8w9RCkaOQddW90ad/tJi6f2BBrTp03p/nDCSfNTbqkw
         WkXg==
X-Gm-Message-State: AOAM533zBXYzcV04bJCU5u8tIV04FDB13IL0NnVneK8WdByFHmYHtA4W
        guJihqcdfBRnomdTwiEWXP2cB1fhD4+dgLCr
X-Google-Smtp-Source: ABdhPJxDAnZYRTplzuQP6vF/7wJtm3yQoRMliWrqEwet/mC9QgVSMOYJumRnmZU+SiKeay/kD1p0qQ==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr79421171wrp.286.1609715589703;
        Sun, 03 Jan 2021 15:13:09 -0800 (PST)
Received: from valhalla.home ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id h9sm32571018wme.11.2021.01.03.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 15:13:09 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        sergey.senozhatsky@gmail.com, mchehab@kernel.org
Cc:     lenb@kernel.org, yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com,
        robert.moore@intel.com, erik.kaneda@intel.com, pmladek@suse.com,
        rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se, slongerbeam@gmail.com,
        heikki.krogerus@linux.intel.com, linus.walleij@linaro.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 12/15] media: v4l2-core: v4l2-async: Check sd->fwnode->secondary in match_fwnode()
Date:   Sun,  3 Jan 2021 23:12:32 +0000
Message-Id: <20210103231235.792999-13-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103231235.792999-1-djrscally@gmail.com>
References: <20210103231235.792999-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Where the fwnode graph is comprised of software_nodes, these will be
assigned as the secondary to dev->fwnode. Check the v4l2_subdev's fwnode
for a secondary and attempt to match against it during match_fwnode() to
accommodate that possibility.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v4:

	- None

 drivers/media/v4l2-core/v4l2-async.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index e3ab003a6c85..9dd896d085ec 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -87,6 +87,14 @@ static bool match_fwnode(struct v4l2_async_notifier *notifier,
 	if (sd->fwnode == asd->match.fwnode)
 		return true;
 
+	/*
+	 * Check the same situation for any possible secondary assigned to the
+	 * subdev's fwnode
+	 */
+	if (!IS_ERR_OR_NULL(sd->fwnode->secondary) &&
+	    sd->fwnode->secondary == asd->match.fwnode)
+		return true;
+
 	/*
 	 * Otherwise, check if the sd fwnode and the asd fwnode refer to an
 	 * endpoint or a device. If they're of the same type, there's no match.
-- 
2.25.1

