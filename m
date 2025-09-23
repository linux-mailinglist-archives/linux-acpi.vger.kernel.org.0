Return-Path: <linux-acpi+bounces-17233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B108DB96CA4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3E3B450B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF53320CA4;
	Tue, 23 Sep 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YcvwBi4m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619230F55D;
	Tue, 23 Sep 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644357; cv=none; b=FS10b8Qefv+hJ9N3xn2MIRjYoVX2kIbJctf1Q1xTlpdjrLKSv/f8XvYiFz4lvACV97TI6+1mU9Nzt4bGFKSL3XRDfASd6KBpPMwmZMiAaFEulclqu3p1IVYbWTD/nz8F+5QKN7oKw+0jd7a0zhYmr3AQShO8ilhuyQ3jD+pv2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644357; c=relaxed/simple;
	bh=2ejW6fUJjgsu4Q59dQ7RNOpiCfhMXgQ3fp4Pe/AK1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxplKIBtRJ3zz2cVxJGSuRqQkUvvHSbITh7/pFdP8a6TUyLkFObjBE4SmDONKAQguWw3IdsRSdYinTeFJYxOaAqN+jP1RSbh4O+91BmJn9JC/oeA5i74XcOzmGvdZEMGaDKyINz5KhavPK4RjRgHgxBnkdZlHpGvYqeEX92xT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YcvwBi4m; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2e
	jW6fUJjgsu4Q59dQ7RNOpiCfhMXgQ3fp4Pe/AK1SU=; b=YcvwBi4mDOCTukG2wK
	leKNF58BWyRpnkHncEzGj6Ia1T7v2jEXne9v7cFjTUN8Fy7Amo6Dvesr0tMkwfh4
	H5/lCdttoxFzlQis02WxmXe6zJv1J4duGjXp42xXDNWhwNdiP69Ug8t0+xju/Dzx
	4vMpzlLWoK1e0NvmJL/WFgtTA=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnfZRayNJoT6zdDA--.200S2;
	Wed, 24 Sep 2025 00:18:34 +0800 (CST)
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
Date: Wed, 24 Sep 2025 00:18:33 +0800
Message-ID: <20250923161833.1307303-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910142653.313360-1-luogf2025@163.com>
References: <20250910142653.313360-1-luogf2025@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnfZRayNJoT6zdDA--.200S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF15AFy7ur4kur4UtFW8JFb_yoW3WwbEkF
	yIgrZ3Gw18AF17KF45CrW7Xr18Wr9rW3W0qa1rXFs2q343ZF4DXFyDC3Wqg34xGw4xKa1a
	yFW5tr9rGFyakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Tlk7UUUUU==
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/1tbizQrRmWjSx6sR3wAAsX

Yes, in my tests with battery hot-plug, I observed that
acpi_battery_notify() can be triggered multiple times in quick
succession. Only adding a lock inside acpi_battery_notify()
is sufficient.

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


