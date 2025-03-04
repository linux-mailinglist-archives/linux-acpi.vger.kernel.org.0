Return-Path: <linux-acpi+bounces-11748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B5A4D40A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13D3ADA47
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 06:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5421CAA7B;
	Tue,  4 Mar 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIv3NefG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1C13C67C;
	Tue,  4 Mar 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070882; cv=none; b=dH0EcYLhKOHhDNFlpYnxkdCFWYLED7VpVRJQIWL+Vf1wfJE/poBuTUutrHjNzUDnJSTCgUUjoa9DHqlO9fHey9QXu5W9PQ2fV3xzu4W65whViop820VIeiGlNwyEjdBaEwP7TfLepDP8pv9otFBSoxpwhXo30XG7SqRijQkbYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070882; c=relaxed/simple;
	bh=2evXEWK0mr645FbMREGaH3Ahgwgh/0pXncUK/iaq3kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=su5h+yGz7yMVq8P32cz/FLHkIyo3mppwc5dcVrisVdsTsSN/067N5TvaFL4hhbbHNiD1e1WIy38MFSu+rs8c4dBjM4LET4ccqhO+f0PsAzup8FaUI6q0nnuGoIgzJgq8nauN+m+hZTMe5vDYYJEsl/6VwNU9X0XBzjxz6H0fCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIv3NefG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D41C4CEE5;
	Tue,  4 Mar 2025 06:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741070882;
	bh=2evXEWK0mr645FbMREGaH3Ahgwgh/0pXncUK/iaq3kE=;
	h=From:To:Cc:Subject:Date:From;
	b=NIv3NefGz6ynuC6Zp7VgLIqrdaNX7RqUIuCuE19nH/4WtkR1jdtwKntA59Z6AYBdL
	 hIMa5fI9TltRsXS4pRrlBe8ho/mHfX2CTBeK+rJ391fZoWGePcLspK5gRalovV8FGc
	 zvNv4weSYfNXmc5jRQN1bDqggq6WK7aLUIOcg+PzH7oZVD4kRfpT892xCct/ILiya0
	 jLkQoNA/uL7LqmvBw3AVoRzuvlK75BjHul/GtatdLnwh9oY4RFahTS2g1X1DgVYloA
	 WKsLQDuuv27JN9+DW1argOg7e8aaGB/ZAr9v+8FetF5HxaSxWnt0y6Ik19QMlgf8Tr
	 NEN9c97EF6FHA==
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
Subject: [PATCH v2 0/1] Add quiet/low power compat code
Date: Tue,  4 Mar 2025 00:47:44 -0600
Message-ID: <20250304064745.1073770-1-superm1@kernel.org>
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

Introduce a compatibility mode to the core that when one driver supports
quiet and the other supports low power that allows both to enter the
appropriate mode.

There have been some other attempts at solving this issue in other ways.
This serves as an alternative to those attempts.

v1 -> v2:
 * Drop hidden choices.
 * Just add compatibility to the core for low power and quiet modes 

Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
Link: https://lore.kernel.org/platform-driver-x86/20250228170155.2623386-1-superm1@kernel.org/
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Luke D. Jones" <luke@ljones.dev>

Mario Limonciello (1):
  ACPI: platform_profile: Treat quiet and low power the same

 drivers/acpi/platform_profile.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.43.0


