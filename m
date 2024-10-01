Return-Path: <linux-acpi+bounces-8522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274E98C798
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 23:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8DDB2239B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C31CDFB8;
	Tue,  1 Oct 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Dt0ffc99"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EA1CB32B;
	Tue,  1 Oct 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818139; cv=none; b=XYO3TR3EtzosOrQC6PjVTNiZasYoglxeGdcXkOnKJeusIktmOXtfcPU+7zlzR/jbBJULraSO34jAw8hG9vkov9lzlMs+Ll7fHObvWogT+0akO2a7heVHmTCWi4WjfNnxvMO9ge9HAqRl+hymjD9FjqG2VSyHmpzTHYOb722dz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818139; c=relaxed/simple;
	bh=AafKZ5pS2zbVRzFlX5Zh/bUiJojDOmF6+PmEV0jlgiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uc06SgdI3h0VvrI/ABy3waqqEDSZXv21Ipw0XWIURIpZrEWZRj5w/HnhB4nTy9md8+hry5xuZYElaRydjNDVUlkceo2tca6WbPRz7QOhb6MyqyC6wW+vSjbzBv6AvIWGu30YuLotBSmUIgZ1tgIHlL7H+YfYISh0Ct8qxutWciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Dt0ffc99; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727818122; x=1728422922; i=w_armin@gmx.de;
	bh=+ndFySRJ6LC8Z/xWwO/bJdD6goFzhWIhaj3bflfaz28=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dt0ffc99Uwa+xnywc40vCEHgOWp9spzdNAE3U8F+yZkawB66/iriuQvn/bU3Hj30
	 xGDmgVYft1iKSydx8WHziPkm5sIqRqpNZTVnQhM3rKozQmYj7CdIbIH3qSMbSP+Fz
	 1ni2TsUk7I7AfC9/K2TxoI63eKFngxJG32PGu9oGWVCa6i/loW+Go4DcMWI+j5Xoc
	 DCdpDcYXMIpZXUOH0tOnkgG758H30XICLPdW5pQDsJjrxCt/stxaRgFTtiFZ812FW
	 IGWNgwGLhnmC8MVAGE/LhtxWOtIkJLfGBomkrbh745decOdFtrmuyW7l/TxL9VVD2
	 XIowwWDJbaPl9tIhvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTABZ-1sSliY3dOR-00YaE9; Tue, 01 Oct 2024 23:28:41 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 0/3] platform/x86: dell-laptop: Battery hook fixes
Date: Tue,  1 Oct 2024 23:28:32 +0200
Message-Id: <20241001212835.341788-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dZIo4Bcj2b4gHwu0ZNrK29bqK0fWnde4C7Sf6nxNn7dxLNdsMmh
 E8vnt1Skpt0dV4uSq6X1aNh3H89aqGJom6EAxeTITNgNZXGh4Zs4AEsi16LY+BtMonNSqLp
 J0rUNG8QI8cd9Hb86WFVWZ/XPNTSSWJ9StTOU2TP3vpUKX0bMvZHvKHjpdEC3uVowyAAl4O
 q7FdZNThsOXjdhXEgIE0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PSgKPVFtHE4=;ql5HjVDTLx2/DVJ35okMB3OwAJT
 YU0N0lIP151tvUSVaOH1BGd6F2+O8tPWyEVaJE/JPVdRw9MLopC3tIeI6cdkwhXfCdXUR2W4I
 x58xhyprN4NzmxSyA90yvTETQNZXMp/oXwmOE0bykTNIMHT1yxVTscTQghduAh7WKSPikj1M1
 DRMdyakHguj9mZRPsRh44RyH3fAMc56ywwjBoyC3t1IuoSqCsuhRmvIuJmtl8sgg3i3Np7fez
 /GZftSNY5ClHxHgcxCYloWYhYkkShxlT2w+UeH31RcOXx76NU/cyMEOCWm0ZkJFIWA3ldJi5X
 cQfbQ6pLJ4pMFu3uVdAHnmxTo3S3oygOIVYqxJtP3eHLKOiNEntsVr52biThNtEs4aGXNbd5z
 OLir7nzCLNq4tom6AXgFLuQ1fXD42bzE3g8qu4HwcwbE4hmWfiGFxyUiXER2reN+kXOxaaM+z
 91HJF+xb8+idRSxDUAEP1vtpHmP2NaSpUaUb601yZpPnMOl0Q+M+SpNGp0nrTcZZ4WFbRRsE0
 tGrhlrGsWaDvXKsflKDfBKJQ5Kr/+3yBBhzTPTjEps9cZODVFvK1uVP7oKho9doujHBh6BALF
 UOKRmNNNy4qhFoRuC0SG19JTvQJkxeOycq9qcZLIHqiG+OlMtfJMzjlBe737hj9jzCgdvR7l5
 h/1Js8kaX3ORcoanHFYdH4r7prp6ig5HcwZUwTtHqwbDWmSkCcqsF0CQYhbg+U3Q+8YAPBK5q
 oM4PF19jzg87HPlJdXuFhZjOiSfxMBeccOQU/cN1JS4wFKLizUzFhVAmDDlVjzA9CtRwLPQX0
 /NZdkhPLETgyuChAgCLKZKLQ==

This patch series fixes some issues around the battery hook handling
inside the ACPI battery driver and the dell-laptop driver.

The first patch simplifies the locking during battery hook removal as
a preparation for the second patch which fixes a possible crash when
unregistering a battery hook.

The third patch allows the dell-laptop driver to handle systems with
multiple batteries.

All patches where tested on a Dell Inspiron 3505 and appear to work.

Chnages since v2:
- drop boolean flag and use list head instead in patch 2
- drop mjg59@srcf.ucam.org from the CC list since the underlying
adress seems to trigger random errors in proccessing (help?)

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


