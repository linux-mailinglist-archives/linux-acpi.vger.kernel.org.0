Return-Path: <linux-acpi+bounces-6941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E761A9347DD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F59FB2218D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 06:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F453E22;
	Thu, 18 Jul 2024 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="sTuhT3YZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from qq.com (ec2-54-164-151-162.compute-1.amazonaws.com [54.164.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218D4D8AF;
	Thu, 18 Jul 2024 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.164.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283158; cv=none; b=VRUdzmaT3IowEGr4/5hD9QSTSBF3TKeu8XekbKnu1YsH8dmX36lOQwGmlTZlA14S4LLnLT3W64A7ZgDi3MjYOLlxlA2HzfEl/24V0/pT0iv6A5LRSgqrCG9sj6hJqg0hSDM8rquyk05XqhmdCb6KMbTHyooSySDjS7k5bKKLl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283158; c=relaxed/simple;
	bh=7JUm4p+EuPVcOm1o3oLVGCkZZPHSDs3UrfRpHozmgvw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DWpg/mf4lF0y/BOekA1KJSavICsI3eT20TjXxZLpzPVWFTdFIeIq0EPQHWFreK7mZIY2y/DBfkZn31Xv2GC4/XV7g5lhdNHpC2tQy/f0FpM9XMT6H3CZn2AFNYIwFfAOyPbDWwQ7xq8nPu4/Ri/R50XVZsKro+YcjLcfH1EZyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=sTuhT3YZ; arc=none smtp.client-ip=54.164.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1721283151;
	bh=/7iSlBFI9MY1Y4PScPXpFxG9gotJAJRZJot1OTuuAO4=;
	h=From:To:Cc:Subject:Date;
	b=sTuhT3YZZ0w834jLJzowFUsweOOA6PtU6o5edzrkwEiaC5/xSFZeo7R8ZnU7Xn0ZW
	 1/2/yrhKVk/eQ8vlT4zVWsGni9B4l5zedXbG5D4YXGszBfzuqmZ/OpAUuTuCfjV+BX
	 ruyx1n0546ceAl8lPaYL66mB1mjnQ/8k+qqKNDE0=
Received: from xp-virtual-machine.. ([111.48.58.13])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 172BCE40; Thu, 18 Jul 2024 14:05:50 +0800
X-QQ-mid: xmsmtpt1721282750tsh8h88qb
Message-ID: <tencent_4A21A2865B8B0A0D12CAEBEB84708EDDB505@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS7OOWi8VYXIKN4SmPNanHlFkl9M5hD6udx6uGqWXekcsBDUflRr
	 8KTN6NXcomSsq+VpYWOngnszoM6c4U+0iVmxxpYcH1PgR0BIqlbBdrY5jKrls5/qeZFsxCMCkcfB
	 WiJmTrupuW5qhCae0maNRwA4X+4SBX+RS9gDPpVIXawM5hzXur8pTfHliCmD5FsF/Qsii1qBdMH4
	 pftNc37JpPApe4y3pgz//n1CM4YCK0bz4d32l3aj5oIaeb1nU1KGGIJ3LrNhFrtQ6J7tS+TaBcnL
	 HVT1wnxGdLrXwEVSnWdmj4aZ9DQulwh3rQRVQUY/kRGilOXd+JYRMzZjCFtg+rR7CKrUZ4d+gKbB
	 R8vO+Xf/lcCQbQxw5ySCj/QEqXfArnP5W8jYkYqsCJLqjv2hCMXsAyC39wfyjxIwpMipLJnu/PQt
	 zjJs2TLS0OtUkVOnKWnW6J+9qyMgGQQ9zdBi3AXN7f6qaWbUQ21mFMxnf6p1N87gWsyPmp5YJzaE
	 v9K7aCcLUn6pG4TeHn/x6HmHAPvkm0czYHKShGvagq8v05q5Hh8zsjcVmhgpWShI6ryZELmMcEa+
	 FrhylYHCeOh2OiAwCBEy7ZU66BS28zmND+mNT0ih0GQtUBEiWnFNYQH4spbmGTzPuxQI6cQ3gyRr
	 0CJb0fui5mkHKWS9mpp7x6AxHdp6FW4+3O49MZf0DTAUtBaIknRqA4rL8564M929xpU5Z50EVnwS
	 Ndp5E/0nr3mmGHfrrONi68cUoJ9vuypjm/b0pjE9h6c+4rVdKEC/wMTx19KBudu+opO1LlY7ffUo
	 CqnszrHtSmirAvhivFfaoHXZRT+dv0LhMBu560m+/Y236W5QDAJaJzdv+ZhoV1dpYpQdW0Hz9S9F
	 7LhPuseEtngoekBPkb3AMkhtEexAZ2dyWgccZ458E6oikL5izpD7NkSaKV9byYsBrqGS3n+HEDYg
	 PWKlOLA38rBcnxAquusPXigWb6YD5WNLDIz3SrZve+PyTU13n0ckXOS0QVzGgAWP+QRb9uMMf5tx
	 jufyIg0BLzDEoQMNHitn2mAYVuZWZ+0IAa3GYhh1OTeRxlE4gTPtcm2qrM5bA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: xiaopeitux@foxmail.com
To: robert.moore@intel.com,
	rafael.j.wysocki@intel.com
Cc: acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	xiaopei01@kylinos.cn
Subject: [PATCH] ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_convert_to_package ACPICA commit 4d4547cf13cca820ff7e0f859ba83e1a610b9fd0
Date: Thu, 18 Jul 2024 14:05:48 +0800
X-OQ-MSGID: <3e39c54f8278e163691d629f1cf89bffcf4c6031.1721280951.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

ACPI_ALLOCATE_ZEROED may fails, elements might be null and will cause
null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/4d4547cf
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.34.1


