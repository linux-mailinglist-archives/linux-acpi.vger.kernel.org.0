Return-Path: <linux-acpi+bounces-8361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4A97E051
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B812814A0
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811D47F6B;
	Sun, 22 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EavTsX1u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A731C36;
	Sun, 22 Sep 2024 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987247; cv=none; b=Ih1iZwtZHdWyC4phDQ0K164MP45lwNX5o/Bz7HZPTlPH3E3S7PY8j6KCfVVSUavcR1dI2l8gzi/njdiXr2eu0LjRCPsb3t0kG3kBboW2wWpihj/aNwdGL5F0LMy3bAfpmxhGtYm25zV6Ua2vMuSs8fw+b+iOtmdTV4OwpfyHCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987247; c=relaxed/simple;
	bh=Ps7FHAJY/RfCUHZixeDFA8CrwuBfIcu9K9jwsP77ixU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKaLky4VdXSc8LqZhuUSFo0CM/9c6Uv42OQxc44uJX5ig6Cszqzy+A0VVy/1gcQ3eT9tig7h1BkrKRsfxXAOb48aD93xE6WNdQElpCLOYCv0a/tvoZT0W4BkSUcZ5vrpeTI7zJxAVlMxMwepi7QI2KLkvexni7f30Ro1zJZabys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EavTsX1u; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726987229; x=1727592029; i=w_armin@gmx.de;
	bh=pIhGNudOcMMpZNkxR8AJ7UjGcU7dPxxMASAbODO8W+o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EavTsX1uV6iR7pImHJwjUPaWUal4xzXws8AUefcTGHEjgjYdJWYQmi8xGSVQINQr
	 GSnOkihfGyz7Zlc3dZOFT4xg48j9Qnk3eas0w38JkPP4OgXN3X99T+gt6Ri9YQgdu
	 olllFFE3jndh13LmFS9Xu7bn7veWmGvUVul/GWYznnaIQNOT+zQmJMhWg1fzbNXtd
	 Fm7+lQb7cPhZy1dzVERlVRSli1wUB3n7y36m0CUnuPvqQgw1mKeyrWCTwAak9y9vB
	 OL1d81Sk/cpUu3lAYxaBFVQl1g+BTeU0GmUfuaen5RfDstSeHUk+zwfuRKpX66Dga
	 XhIoVYRGHxgC1WeB+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MpUUw-1sBAcS3xj2-00ZSok; Sun, 22 Sep 2024 08:40:29 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mjg59@srcf.ucam.org,
	pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
Date: Sun, 22 Sep 2024 08:40:23 +0200
Message-Id: <20240922064026.496422-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R0GuQ+7kuxzgYnX6U10L0arwle2WhkUvOR+D0QhMQBMhbn5ylmd
 6Q25iYS9hcQEhEd8Jt2QlpOJiY7S/563a0g6+dPbP4O5yzXZCnAN6QWWSgy+FjEERLDe+en
 hKgxv0CVA5ClaYkkS/pzEVQVfEwjql0TRwQumjyWEOz4ykXQsTZThjTL8GZitJsUYaD4Gw4
 ZM6Q1OOEbxKlFQ61SbEqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KbQ7QolR+AU=;VNR1wpfVSaor/OTy4yo7qbK9nIK
 a0ccxeYd4asgXMeIx7/6P7fJQMYGGREar1kt0ZYbOo8sk/2sFcEG2cPWu51UTIn2kyvURHnqE
 PkSS5bnxaqF5z1n0nvDJ9YXzvl7TOXCXoMUqL3oRckA4GAtn0xDlMTF1myI4Xz4N/LITYUVsu
 kpYxsw8oG4HgXE6asepap3HrBWywQ1MHbYoTCiq/7GrlZ5kpFsiL67h6Tspd8e5izZLJV0Mzl
 L0PNfE+26hTrCXl3ydoagN2Jn7NbXxmdgvZi/BvSSRDFpn+WHvYWS3i3j+ItQ3kKQ5OrS4Hnr
 OgRl+dCS5+M/usgXmeHgUdaTqhs/BJoEXEGUdaEKRPExlavgbo1ua0QvOBoUu+Y/Mv7oEj/Ns
 /nAcRanesN1wSPyzo4yJwzDw1KYSdgc190HJqflZ6ef+1ZtVrI7ztK2Oty3VCNkbCvwOpK2R0
 oEsKsNtUtbTEIfnGU9P0Lea1bjn66oSqMhIRi28FrswW8jCy2jNaNOOVAucmK+Rw0HxBoaySH
 B3aW8+nyVJTRV1syzhGzIHWnd4ebTufrLRdaA1bZK/+3InZfMR4veR5kIHf3g3A7FaushXDGz
 IajhQD+7JSAHdC9pqRjWF2KDdDODFn48js7fUCwZFUR4faphhTRzOiXsexUr6vkbYyW6CP2U/
 JH9Sw2DXOh/CFov4HZipOtFfEC2CkTwh51dv7N8g/LNuWcaHtcVg8EoJ9MImVDK0/fZxxinKL
 1Kb023r+Ycf80SFY7fJ5R7zCePrgMsc0G0WnUECAh0Y8y8u+QgN/Xa2DHGFdELuWuZv62fIAG
 ZoYuushBJlysqUil4+8YZyyg==

This patch series fixes some issues around the battery hook handling
inside the ACPI battery driver and the dell-laptop driver.

The first patch simplifies the locking during battery hook removal as
a preparation for the second patch which fixes a possible crash when
unregistering a battery hook.

The third patch allows the dell-laptop driver to handle systems with
multiple batteries.

All patches where tested on a Dell Inspiron 3505 and appear to work.

Changes since v1:
- fix the underlying issue inside the ACPI battery driver
- reword patch for dell-laptop

Armin Wolf (3):
  ACPI: battery: Simplify battery hook locking
  ACPI: battery: Fix possible crash when unregistering a battery hook
  platform/x86: dell-laptop: Do not fail when encountering unsupported
    batteries

 drivers/acpi/battery.c                  | 27 ++++++++++++++++---------
 drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
 include/acpi/battery.h                  |  1 +
 3 files changed, 31 insertions(+), 12 deletions(-)

=2D-
2.39.5


