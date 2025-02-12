Return-Path: <linux-acpi+bounces-11130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5239A32FB2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 20:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42254188B450
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9D1E1A32;
	Wed, 12 Feb 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuP1EakZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E8271813;
	Wed, 12 Feb 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388678; cv=none; b=IINz6zE1RqfwQsmMk3QTHI8H/DYZ6bFTnVj63bXUk6d+lESKwSEUUik3w3VOwq70mgsi+KDzFd9Hs6PbwLZjjaVo9MkqUNjrIWWGKZDdS9QhMIT51EWFP/B6bNas5BxAmV9u0DfhusSBl8LINbyzLqS+/cho3Z0TduxZNA5J2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388678; c=relaxed/simple;
	bh=GfZdTX/Oy7XJ8tKG6LUgqykp1o40xiaIANvWfqZKCJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejFbGYOx74PvTr7R2yWtGFZLSsVY+qacMfM2iSl+r4AHZbAbKfOe63b6pzJtHCki5sOOfhn5LWxYYQ5CeAFE0HgU5nG7Y/PEwrfPTJGtHNlO6XFXJAXefc9n8dYIADI/fCT6pCAJTMed45NF7O7bytnqSVn8KwtFqyvh0TDhzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuP1EakZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6efe4e3d698so1237957b3.0;
        Wed, 12 Feb 2025 11:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388676; x=1739993476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxerhnt8Y8id2USTwJkEjWouua1WjZ12bm3toHhyogY=;
        b=iuP1EakZsIaBkFdEtP2V7okMjDa0Pzu7YuM2oEEFANOtZybhmovPlBx+SsEl5PegjV
         HItXKrg3pI+rRui6D+kl6JToNJ9tvTC33HEeCz70vWXLqpdSk3j4ffSNeJ6TnaZMyrLT
         Dp2M8MR9NnL4swhCJYxkV+Iu7sh8/aOCTNvanYdLZcY2YAqU28/byudeC1lkL5d6po8J
         qEjujeuzgFJu39zSetZ6GWBCMYAuik7pxwJ/lZ+rv+CwVCxb1d6NFSmMyedsCsSZvxzF
         p0R+2wOGwoJYwlb5r8quVFAiYjHDPZr6IPrcu3KHcA8IZeWtK3n2XfIULE2KVYsNx+h3
         p1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388676; x=1739993476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxerhnt8Y8id2USTwJkEjWouua1WjZ12bm3toHhyogY=;
        b=IB9D/4GfUeUjNay6uFSAiO8C59eLW64kkA5WFGxfTnLUc3fyn4Bb5FMTTUaGahfCpK
         oRg4f4055kz1G3aQgCRN94j/4Pv4hPqB98Mdflz7TmaQtMh36Ist6zrx6j2PR5OX1jra
         b/XuXtwY1LpyTSuQoIlFvN62sNLHI0gttnJei2SKYNOzE70sXjUVUPDZzmwyfBREX9rC
         zqPgy7Ny/KOl+xXieMnCbpVq+ylb8tSz+pKiwW4ykRX/krswPdPySbBLzLqesACa8jEK
         3anKMpW/7hpVUFHmeE0AHn9u+1HaueJRiBJN+Xa9jMW8hZ3h4FBojA+rIrR1j5/fMHAX
         KMZw==
X-Forwarded-Encrypted: i=1; AJvYcCUqy6buLbmDG/DjnSX5OPbgreYrdzijHZNvMlM1teyBdb0JNtsFZ4ItNffQFsN3Wx1jYnnAeO0bKwsc@vger.kernel.org, AJvYcCWmKuYfk4w9y3R7tMkvGbs70MywBq0xvEqrHer547P8UwlrG8+Ba+19Tja1OIawzZnn9rW59beVPu4x7x0U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jsecv8O13luTHx4NFkdzR60wnHUs32/wXk5DvmTjVxXewrt2
	uCbOXC3Dbs39Gv42xBFJ/64Su9Cg4BubJB5CogkbUGRZrCInpSv9
X-Gm-Gg: ASbGncuwBm0RTzZvUAjCqf/vAvwsZdiv2BufjAx5pFTPvGlBiXJ/93kD+9JE5s6So3W
	dBpGiag+BAG5EthFTaGvFBOWCPJSDA1fmRSX7Oht9xQ5Lwr0SPvLpvspNE6uimBhpKKXU2y4JRr
	BO3ffJH35iZobqwrPikHl0zsFykQ06nBlUjABq8krFCnGlvKNj0xHrrb7SIih6iVNQTlnvmSh8Q
	3rN4m03z+QDhTLj0XDwWzS2O2AGBWzP6uRQErGQMnDGKOf5OPb79/DktgzM7foZYERcnn75d0vY
	kcJDNoMkTO7ppJFkTj3ARh07fA==
X-Google-Smtp-Source: AGHT+IHZTmVClcsZUB5sJHSCBll2LFC3eeHBfHQFpiL4RynRDnie9rUozkzvnBkA6YLecFLTVlH+zQ==
X-Received: by 2002:a05:690c:350a:b0:6f6:c95c:85b5 with SMTP id 00721157ae682-6fb1f286679mr43317497b3.25.1739388676177;
        Wed, 12 Feb 2025 11:31:16 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:179:113e:f067:4e25:4298:6451])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd1fefbsm27889097b3.46.2025.02.12.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:31:15 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Kurt Borja <kuurtb@gmail.com>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: platform_profile: Fix memory leak in profile_class_is_visible()
Date: Wed, 12 Feb 2025 14:30:58 -0500
Message-ID: <20250212193058.32110-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If class_find_device() finds a device it's reference count is
incremented. Call put_device() to drop this reference before returning.

Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI platform profile")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fc92e43d0fe9..2ad53cc6aae5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -417,8 +417,14 @@ static int profile_class_registered(struct device *dev, const void *data)
 
 static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
-	if (!class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered))
+	struct device *dev;
+
+	dev = class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered);
+	if (!dev)
 		return 0;
+
+	put_device(dev);
+
 	return attr->mode;
 }
 

base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
-- 
2.48.1


