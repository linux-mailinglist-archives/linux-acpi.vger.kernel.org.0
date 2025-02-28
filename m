Return-Path: <linux-acpi+bounces-11634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739ABA49FA7
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B6188B15D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8C1F09A8;
	Fri, 28 Feb 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9XrI1xl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF51F099F;
	Fri, 28 Feb 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762122; cv=none; b=o2m7jKNkM1bDmlecW9bXnU+IAz+Gbc+x0+VCsr4gKLK94AqQY4hhllgNrAhpVLKdl6Jm2XwhA6ktsoP0fuhayajpVJDuGcGKx1XIvWALp95Z7IyjgtYxq9DZW2decevIB/xP/QlBvrctUcjvBIz+4giTLU0aNwQf2T29nXnMM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762122; c=relaxed/simple;
	bh=2TOJkalZfekFSiFCcz7C1DboNeITJ4wSKaxIaSPzOtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxChj/xtl+gDD9+ILmOhMilGC01wnvDIRKREMgHwXVpNKN0WYoCZW+HeswIszAEyBkG+5v9hR8krFfXQDgLxZ7l1TonxMsQwKbHsHkC+AuAwYB6n7lYNpTdtMCDGzi0wDh+o1oGWUVEV2dzP+DmlcY2tMdA4RvB5i/66BRlvIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9XrI1xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C59C4CEE5;
	Fri, 28 Feb 2025 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740762121;
	bh=2TOJkalZfekFSiFCcz7C1DboNeITJ4wSKaxIaSPzOtk=;
	h=From:To:Cc:Subject:Date:From;
	b=T9XrI1xlAnPMMuPdpeXF9hqoG/gsdzPm2XXESKV/pLLUZLh4WP4TjmqnE8nkJq5Sf
	 HTQBHDt1axAfJD9S/ZZcA/qY1XkTySLON2Yk/s1g/WPaFFzDrbiQ36AMY0rD643U0r
	 7Ard8hdX8vg94TXcZojfOnPanmfzmFDYv6Wi7Q6Qdl4gjRubG3EbTmnd6tegz0RRaG
	 3hzxqdoLDbkQ1FyTs9qMuFTq1fQUeTOyog3+d1DaslArYh282ZkQm2h9H3NW5xpaZ5
	 fHrROjNW/XYlV5A6xWVu9ZKVl6FML1nhGvOPbUsz9tGe5qs63JT4TcsqIy9QdsG8lo
	 k97RSwb0jsWpw==
From: Mario Limonciello <superm1@kernel.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org (open list:AMD PMF DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org (open list:ACPI),
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Add support for hidden choices to platform_profile
Date: Fri, 28 Feb 2025 11:01:52 -0600
Message-ID: <20250228170155.2623386-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When two drivers provide platform profile handlers but use different
strings to mean (essentially) the same thing the legacy interface won't
export them because it only shows profiles common to multiple drivers.

This causes an unexpected behavior to people who have upgraded from an
earlier kernel because if multiple drivers have bound platform profile
handlers they might not be able to access profiles they were expecting.

Introduce a concept of a "hidden choice" that drivers can register and
the platform profile handler code will utilize when using the legacy
interface.

There have been some other attempts at solving this issue in other ways.
This serves as an alternative to those attempts.

Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Luke D. Jones" <luke@ljones.dev>

Mario Limonciello (3):
  ACPI: platform_profile: Add support for hidden choices
  platform/x86/amd: pmf: Add 'quiet' to hidden choices
  platform/x86/amd: pmf: Add balanced-performance to hidden choices

 drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
 drivers/platform/x86/amd/pmf/sps.c | 11 ++++
 include/linux/platform_profile.h   |  3 +
 3 files changed, 87 insertions(+), 21 deletions(-)

-- 
2.43.0


