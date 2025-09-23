Return-Path: <linux-acpi+bounces-17232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8BB96C5B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB1419C5FEF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35883307486;
	Tue, 23 Sep 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cL4raWTm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B22E62D4;
	Tue, 23 Sep 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644074; cv=none; b=qjX0Pz6uk5a6+SBbrzur3T2OGShPQVe1dKvN30LcI/7QNHUddv9wx/1dMMmXus8lxlEwvtUj3KEC0XAcSiwx1Iow/UdQpA4RRcjBw6Uc3eD18jK/1w4j+4KV1AlMYrDnq+MrcagDKeplSWTcmBCIMQKa+88IdVo6hYvTL4DF0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644074; c=relaxed/simple;
	bh=zD5sKdXV69qCCacGjQGgmY4agFKeIb7FzIobZ/nErdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvF8Gx6btW2KfSEFFB8dn0RJkN2M/8ODL2a/krSU1Y7clSs/VM3NY8lsiAm15j2hIhglCE381F+k8e1cDSvPLboyABcYE0jKnbSEev7r63okUBpNbuEYyT/otM4H7jCj8agsxdMkW4oSgZsmk50/rVJwpAcMPdMQ0q9wdcSQTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cL4raWTm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zD
	5sKdXV69qCCacGjQGgmY4agFKeIb7FzIobZ/nErdY=; b=cL4raWTm5RLTDHOqPW
	mAdVLoF/si3CMENCSmyRwq3jjvGmO7QxMcUbN1vowVqBUYHfQ0yE/qZcbxf7YIra
	Fxi7pYkzdUWsdkPMfzGpIAdVGlSgNWjxSeQjxRcgwdEyncJeoqybsDITK7Of6BO1
	6YnIYAqSuhRFIHHX1Vr6vlAkI=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAnUT5Dx9Jorc2cDQ--.63331S2;
	Wed, 24 Sep 2025 00:13:56 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: rafael@kernel.org
Cc: michal.wilczynski@intel.com,
	dan.carpenter@linaro.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lkp@intel.com,
	sre@kernel.org,
	stable@vger.kernel.org
Subject: Re:[PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Wed, 24 Sep 2025 00:13:54 +0800
Message-ID: <20250923161354.1307251-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
References: <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnUT5Dx9Jorc2cDQ--.63331S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaPfQUUUUU
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/xtbBXwrRmWjSxDJVoQAAsl

The functions battery_hook_add_battery(), battery_hook_remove_battery(),
and sysfs_remove_battery() already acquire locks, so their internal
accesses are safe.

acpi_battery_refresh() does check battery->bat, but its child
functions (sysfs_add_battery() and sysfs_remove_battery()) already
handle locking.

In acpi_battery_notify(), battery->bat has no lock. However, the
check of battery->bat is at the very end of the function. During
earlier calls, battery->bat has already been protected by locks, so
re-entry will not cause issues.


