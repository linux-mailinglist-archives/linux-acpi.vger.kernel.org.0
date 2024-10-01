Return-Path: <linux-acpi+bounces-8521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65D98C78B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC65B282F00
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ABA1CEAB8;
	Tue,  1 Oct 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UmNH48Ce"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8D322E;
	Tue,  1 Oct 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817797; cv=none; b=jzdQDanDRTjNzHeDik7rBkX35VtdTjwk8x081nLlgfY1bfdXkFxk6KZExpPiD5VeMzFTbmWXnAiLjXfQE++pRoFHZLOnVqddU32ip/CHmFJyqK2NI/7Bomlmqg/7keStqtQYLcIOuKhTPSKVQ9TJ/PJGKf+nPBUZ8abuwMgjqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817797; c=relaxed/simple;
	bh=gwl+UvEUYaPrGT3SbXPzo2anqaI06j0D0CplQ+iTjnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bvZTTM2o6AVAQRUjLk0qcSkwbCi6n0lml+fJu1AXbsluuiTI/HN9aBzAdUflGF29JFYCWGtwtksgiAYzbPnG3sVvWto0zOoH0W8+998vstiYbjgs/3I0el9ca28ofHJ7lBllPqePEFWEc7bviAxN7KextWIs+h6bwwu6NHQTVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UmNH48Ce; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727817781; x=1728422581; i=w_armin@gmx.de;
	bh=VP1+d+v/jCsIcaZX1wY8WEBaidTspygfYgGc1OtdNlA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UmNH48Ce9SHuPdtGTv7EfvwISOqMnMyK2j0AQ8wL56FofkDssCmdxez0I6Bm0GLt
	 aOxYcMCXXDeYvt9U/XL4K5GyAa5Vki3hTqA9E3IPHIvgM1c0xUwSDOn3vMMzEiqmM
	 pmrdDdxohYf0x1vrThuYo3o1+KTq27JanErEPoqjNVAxqa0EadXi3/z5CCPDM7/Zv
	 +dNqZOabrzSkvIsPSlN66dsN5q51yzDKVTXAEk/IFyJb01ar6rkSgYWPvlW1WSvDv
	 mAyE1QiLaJFbB2q+0KcsFdWs/ichjppOKwSbRGriYhAnO449QwWB74VyE5FncgeQ3
	 08g1zlnUq43AOO24KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOzOw-1sWONt2Hfw-00Msyq; Tue, 01 Oct 2024 23:23:01 +0200
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
Subject: [PATCH v3 0/3] platform/x86: dell-laptop: Battery hook fixes
Date: Tue,  1 Oct 2024 23:22:54 +0200
Message-Id: <20241001212257.341398-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lDb3s/zMx0Pia/LniwlLF6hwfgcH3ErRT7WSt2OKGbSH1KLqOiM
 IQnk65HWl5o30iURKaDWzpr6MpzWmQ7nkbvfXPfKnrYnExF/ins0KTzeHJe7NcSGVLjIxLy
 KB0OKtjyD7ioow5zaq1CnRj1/8yUdUMktwqU7xxgZZ3ZOA7Hv3HWLClUqq/8tZm5rKc78yO
 Ka3tV/XFKG/mj4YJP0FMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TNB0YZtx3Fw=;EpNy8Wag747tPiSjmMUUW7z3SCP
 iZNUv6j7FEYEIGgUVFCbtREyWkqetBvpfRkMy2Nkj4W/q4V4JPQxF4+V0bL1XG1vf14GnG3EV
 JOD9qG9L/B+O7cX33PHH1ZvUzH8oY67e94pD6XSDkmxeAlg8cKwi31uCL3Eh3752wM9t2lMTi
 IcNyRbGxf19u8mLuzyy+VBrkno1McyZXTGY76aIwwTXEHyCSF6Q5C2H21Vo7c7SdCTYX45RuL
 qUxjH2/sYzgb0Cu9VjXZkG95cdXK8Fh7h/YBlyCY5XBPjgNnkzSTmm0ZwUX3wMLx0fnQ1141c
 5CSteuMfTCBcVxAuHuG2XEEbsC/yy/h+HzdYwn3hByzRe5kZZHVSWhuoc7eZPVTwBxRuxCfZw
 raI5rhFhPLeSNpcvD+M/47GNsGMcEWaIgNi5iI882nLCEwWLFg54QhU2BE+PwNULgJg+yAqHZ
 199eucZ3K2Zw6EoCdHuIlJqLKouGdfkJxekrQAmjbPp78/3PMtmfSj092iscDtAnPml0Ih8Ez
 jKCGPlL/9IfUDumqs+kUVfXUyRPa/oJXaCpUb/bGBu3DFpvwSZJ1TGlAAjGuTJQvk+LAFUl0q
 +1ewZ3dkGqLyABA6CMVsEJqLm4PSN37SP3Q32EQbhK2ti9jrXJrYlXXEbbdJMqPRf9Bm7Scdh
 Xy7+v6Bh3TDuN0CJIZT1jO0Q+l0JPUyFux6KuOzrfVD8fKZCzaEwm63tYDk6hsEKQOTXvJu+E
 jBbQbQ8FHyOejsi6TYO5cSvlzmlGg2dtcP8lHuc5P+XIhx9m42PJZmTatdvlfn9VPYMyDDogE
 T4poEgJvxxt3NwiAddeHNeqzAe1huawnERoAapmidvkhg=

This patch series fixes some issues around the battery hook handling
inside the ACPI battery driver and the dell-laptop driver.

The first patch simplifies the locking during battery hook removal as
a preparation for the second patch which fixes a possible crash when
unregistering a battery hook.

The third patch allows the dell-laptop driver to handle systems with
multiple batteries.

All patches where tested on a Dell Inspiron 3505 and appear to work.

Changes since v2:
- drop boolean flag and use list head instead in patch 2

Changes since v1:
- fix the underlying issue inside the ACPI battery driver
- reword patch for dell-laptop

Armin Wolf (3):
  ACPI: battery: Simplify battery hook locking
  ACPI: battery: Fix possible crash when unregistering a battery hook
  platform/x86: dell-laptop: Do not fail when encountering unsupported
    batteries

 drivers/acpi/battery.c                  | 28 +++++++++++++++----------
 drivers/platform/x86/dell/dell-laptop.c | 15 ++++++++++---
 2 files changed, 29 insertions(+), 14 deletions(-)

=2D-
2.39.5


