Return-Path: <linux-acpi+bounces-3433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F4851F99
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 22:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6ED284FB1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32754D9EE;
	Mon, 12 Feb 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8jYcMjX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A044D5BA
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773519; cv=none; b=ZFMalFgdOM+NBpbMiXc8Jhlvsxlsnfygqt38Ig86OgqdA0BC/9QQnmEUkJGxlo6YIyryAPXxDLy9RSq2NqmHL/UULcfO2tWtIolhnYN3MdEMNJLurcAWW4MePRCAOnT/qZq3ZH9e0/ukNSZ7g/kxscf72RF/byWiksvjTNX88r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773519; c=relaxed/simple;
	bh=iEDFuhE8mOQtSS/B79HZRgChFrCS7/VJXwJaloRdLeI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=LO/Lkc9bRz2sqKpnQ4sotCBTyLD8/neXBG/AYmuT+7pbQZbj1AoCHJBrSOo5XqIF8EECaQ4t5IA2LS1rJTKM7LYatvtv03TbYtxGyAZ5cpteYJnZup56dJ99/rfsf4DB7VTTXFGWIJ08PhboltK18cPOteHhHJD4t+vB+Y5Vl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8jYcMjX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso73455307b3.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773517; x=1708378317; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=D8jYcMjXGapMrTf6EwfANEkNGgsB8HgvdEG7WRrzsTJE/X444g2LdCzD2MmtXsH+0h
         QBxMJrg284bFKgmBpUyNIln3WDEkN3b7T+PbN33+KfEoi2X4zzma0jeKpt+GZj5ujJDs
         lFLlZxYg9VOXx1Jd9V54ejylhkm/UMVmyFPwyX/tp51otbmfSboc4DvILLwDSu38Yh3C
         tGMfcVbJsfJHNGzXu4fIMRDPEeJMxIcErfVcd40FVTQb+iQuRj9oAT1EM7Xz05pQjTh5
         SjgXkbTD7/TMbcot+7Mmf43Dv2ji3FAdjUbXUq1aIkqlLSJeO4QyCn3u2T1rIuYs8YTo
         aAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773517; x=1708378317;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=v+9Hi9v5IuxDnqyUEo2UPzqkXB6gm9EPjH5g4pwdYKLLvp9xUTyqEva8GuTvWv8AYJ
         QK2jp2MJSgyIZMoyskDxK4vAdOwNVWkpMH8IQWcb/HRhsgoZ7FrT7fFgn99ubQohA/S5
         Av10wFKhPHE2cvjfMT7iKmcGFe1sODc6DscbuSqoR4rv4NcDmB4aCsWEpT0ZoV41Z+mY
         z5ZQoyY86wAjOpG9sz8ZjLZBNe7cObH9NoNZ4v5vMHpaQ3C60Nr3WBxi7UPO7TimgWzb
         ZcWDfbSJkEGP/sI3z3xPVMgsva6FmfQfhHgd3l4GN3joIxDoQLU8GgG680u3gWS6jlcX
         Basg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zN25pjPbbNhDWI12Dd033t982zCPY/WcYOgeY84HCschkSscczQQkmOHgGbb2X/3+Fc4m3/c7NECpfRpfqsw/4llml4NKBr4Kw==
X-Gm-Message-State: AOJu0YwEwPg6skGbEJ4fU+DVH/EcOKfvbch+DDGBrbEaioBesMh7MOTC
	eAoCIRqhG7j87I0jig7yqbnAjeIB75rFedOWMOI1PKd542HHzKP9K/Y2DPsx3KdOxF4SViC/gVJ
	n/SD1IfsamnpCFg==
X-Google-Smtp-Source: AGHT+IEv4lMMKOiE36RgkVzlELzHp1ZN7UXS3b79sBBSPdrPmwmnqPYQ3VmDHWPUSWNFThn+cHttRjOIrZmvETM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:496d:5de1:a404:8bee])
 (user=saravanak job=sendgmr) by 2002:a05:690c:e06:b0:5fb:63fc:fac8 with SMTP
 id cp6-20020a05690c0e0600b005fb63fcfac8mr2203866ywb.8.1707773517438; Mon, 12
 Feb 2024 13:31:57 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:43 -0800
In-Reply-To: <20240212213147.489377-1-saravanak@google.com>
Message-Id: <20240212213147.489377-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213147.489377-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v2 2/4] driver core: Add FWLINK_FLAG_IGNORE to completely
 ignore a fwnode link
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A fwnode link between specific supplier-consumer fwnodes can be added
multiple times for multiple reasons. If that dependency doesn't exist,
deleting the fwnode link once doesn't guarantee that it won't get created
again.

So, add FWLINK_FLAG_IGNORE flag to mark a fwnode link as one that needs to
be completely ignored. Since a fwnode link's flags is an OR of all the
flags passed to all the fwnode_link_add() calls to create that specific
fwnode link, the FWLINK_FLAG_IGNORE flag is preserved and can be used to
mark a fwnode link as on that need to be completely ignored until it is
deleted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 9 ++++++++-
 include/linux/fwnode.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 33055001e08e..bd762d90dac0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1010,7 +1010,8 @@ static struct fwnode_handle *fwnode_links_check_suppliers(
 		return NULL;
 
 	list_for_each_entry(link, &fwnode->suppliers, c_hook)
-		if (!(link->flags & FWLINK_FLAG_CYCLE))
+		if (!(link->flags &
+		      (FWLINK_FLAG_CYCLE | FWLINK_FLAG_IGNORE)))
 			return link->supplier;
 
 	return NULL;
@@ -1960,6 +1961,9 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	}
 
 	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_IGNORE)
+			continue;
+
 		if (__fw_devlink_relax_cycles(con, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
@@ -2033,6 +2037,9 @@ static int fw_devlink_create_devlink(struct device *con,
 	int ret = 0;
 	u32 flags;
 
+	if (link->flags & FWLINK_FLAG_IGNORE)
+		return 0;
+
 	if (con->fwnode == link->consumer)
 		flags = fw_devlink_get_flags(link->flags);
 	else
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index c964749953e3..21699eee9641 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -53,8 +53,10 @@ struct fwnode_handle {
  * fwnode link flags
  *
  * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ * IGNORE:	Completely ignore this link, even during cycle detection.
  */
 #define FWLINK_FLAG_CYCLE			BIT(0)
+#define FWLINK_FLAG_IGNORE			BIT(1)
 
 struct fwnode_link {
 	struct fwnode_handle *supplier;
-- 
2.43.0.687.g38aa6559b0-goog


