Return-Path: <linux-acpi+bounces-10241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA209F9EF2
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 08:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4EE188727B
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5901DF244;
	Sat, 21 Dec 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyggin4t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9721DA60B;
	Sat, 21 Dec 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734764949; cv=none; b=f+7DJFD8zS8jaiHP4NJJw8qGS0D+jExGTQ9q8Vg96g3I5CJlKgFTxHdjvZsT9X2TGl1ULQo48b+5sznaT9lxSC7qD/RjZLI/hJHRX5Ru9ljqeE20FL1tbCD9CC1+/BclWKtLZcmCaLyK3MSDARt3t8eqYThmSwRFDbdH9BiZtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734764949; c=relaxed/simple;
	bh=IBOjkAxmWX85HSWhNbeJoEaRo5euzpTy2DrGvjKLh1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVfNlnwNalxghhWUSBcG4srK1BRJfo/1/WQIddNryfETlA0Hcjtv1oPt+DzlXCbHDwVJR5RzPuJovWQ57SS4Jscwr6RAZTMaLfctjG7dCh0dklTej9SqStU43Qg966So6wbtQmDY7UdD2CXYQG7Fx4/LT3yf4RRCMU6U7HWETE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyggin4t; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e479e529ebcso2027818276.3;
        Fri, 20 Dec 2024 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734764946; x=1735369746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaE/bnZbr4TWqX4P0Ld/mI5T+HOu2de0eOS1y64vr/Q=;
        b=Eyggin4tWSJjBevd6d/+QvK6gCmAiJXhohRRSCzMKynIrR/tknZgfckl3xpUmYHarw
         xaZLU1prB90A7ppJgWyIlh4fewcCc3p1z1GNkCyW8zDhlgzvYKTP1EPz3KuE9OPXu2OM
         620I5xMm+ZwWwWi4FlM3M1ggjoC4Wsu01O+jHU7RASNKMvW5OFC9/qkNxwWHXXc97ZDy
         57/DH6gy7QZ15SaIv4+4Q4sx63IfjUMzsDrUBnuobwS0TPdPC0YvNJZtMDX2lC35h54q
         yQddxAtttJZWtCeSi+u6a8i7qSkUNbhbVrE6BqGbCCWcq/d8zRGvXbbogDtrsQOnKdoy
         2vHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734764946; x=1735369746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaE/bnZbr4TWqX4P0Ld/mI5T+HOu2de0eOS1y64vr/Q=;
        b=lyd62CxtOxTB6a6efK++Szly9ayuxFqIg9lBF/tnrbOg5+tzzFfD/FB8HlOZbqOw+s
         f328n6vcgVfeAjqcwYKog5KNso27h/LimGPsmP/DSoZkEIMvUfHv3vKfoYEOFNsHSH5T
         r7PZVAiOsv8Se/l/n3l53kum110kVVLM8lChb83S0jPbSAwH9/FDRH2f9+LJFrED/oVA
         E9V7q+lF68PEvkO5Y1I2aU81M2llgHWD9ZMZTdAdCpPukSunQ9iVucrsEIMOLuqzurag
         49z/jrvlHUJELzkzu8tQVbhYtB/uLFzTI1WMLKFQ2VR0qGtX19xZ/yh10rJloUWzm1YU
         Szig==
X-Forwarded-Encrypted: i=1; AJvYcCVAf4IE2Q7yKrnUXuk6x3JJnHwzgJRxIVwYd3WpcsirRmqMJelTo47Po2/9PhMt0WiInf+7gyom/BjBjkDY@vger.kernel.org, AJvYcCXYOZBEZclTu2YgoY2VW0NNA/8ydSFdZBLHerXeTt3cd21cg5GKesjn64DGi4nyJ+onviO06UqxfKpK@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLW0fmEOSZu33dm8hrSUFfxoopNZTKYrjpx3vLQ1H27eZ8TLw
	ZiaiZN7hJjtI8FOeG532vBeWx0facqrHfLYB8PvQ0lEuNbLfIxahxGb9ZA==
X-Gm-Gg: ASbGncuZ3JcKGAsOkyHhzGhe7+G+yoxN8QIVvPQjJrHeVNeAgxR3njmOCkFZxUcZ6EC
	6/l7geoqxWYWobHHyxZfRQojebz+DTRQDvQYvBnJVvSKz7sGTNV580K5ec4iGIBmDLHtS5xLSXr
	6JE2qpNAawDw66PfgPBaedUwhG2HBg+IbOS45OG9XFL0G5Xc6pTVlC7jMNNbH/Ixj9CHqd7BU10
	UNJbEbQ4a2YJhDvc1P1Hfg1S727QS2IXHNzzquxprvJc9yk9FBzHiEEGKkinHOQ
X-Google-Smtp-Source: AGHT+IEnI43+A2gQFmTCpxHGkCwCiXPkPTkDB1GFq3XiiEX3I1MO9HKAqPNEVbdee/3eX3Jhta6Mcw==
X-Received: by 2002:a05:690c:650a:b0:6ea:ef9d:fcba with SMTP id 00721157ae682-6f3f80d5f3fmr48171077b3.6.1734764946009;
        Fri, 20 Dec 2024 23:09:06 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7498215sm12367977b3.60.2024.12.20.23.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:09:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/2] Device managed platform_profile_register()
Date: Sat, 21 Dec 2024 02:08:16 -0500
Message-ID: <20241221070817.3764-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi :)

Now that the platform profile is tied to a device, this would be a nice
thing to have. Let me know what you think!

I can also replace existing users of platform_profile_register() where
it makes sense, if that's ok.

This is meant to be merged on the pdx86 tree.

~ Kurt

Kurt Borja (2):
  ACPI: platform_profile: Add devm_platform_profile_register()
  alienware-wmi: Use devm_platform_profile_register()

 drivers/acpi/platform_profile.c           | 27 +++++++++++++++++++++++
 drivers/platform/x86/dell/alienware-wmi.c | 10 +--------
 include/linux/platform_profile.h          |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)


base-commit: 9e0894d07072e50b83ef077ce91e504bdb7484a3
-- 
2.47.1


