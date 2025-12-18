Return-Path: <linux-acpi+bounces-19669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B35CCBC6A
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 13:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EC03012DDE
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0813532E6A8;
	Thu, 18 Dec 2025 12:24:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD832E694;
	Thu, 18 Dec 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060671; cv=none; b=c3P2Z+65s1NNeRKMFpeKFBAFmlokIl0UiZw4/sRY3HefeOyHQ93vGEgsNGO7sXeUF5Y7rlFnciErR35+KC42++DL6sbSPdqlRXjzjwbNj1RN/EhXm/BAe3poS9MhKYoktZz7Xb30RzppG8IHH1R+/A9agpmTJwn4kvzv49n8T7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060671; c=relaxed/simple;
	bh=yeujpU7g7d6+UFzpXa0wecW8/4s+ZKJ1w3kBcS80iPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h57dt+AAUVSvK76a5pzJ2CILiuujAqRpK2hpN8xhsMM4xLZHj42MmbMUUobvW8mBmWqSN2Q1B7B0RiMdcpiZ7Ty1Kz2BSdcWMxnEyJHFnlbpSBVTteasQ9HjkjzLiTBtSeeKOWANRnqA+EhGgpNVR+a8xps4Hbre9YTD8A5EnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.209])
	by APP-01 (Coremail) with SMTP id qwCowAC3YGx28kNpOGADAQ--.11790S2;
	Thu, 18 Dec 2025 20:24:22 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: lenb@kernel.org,
	lihaoxiang@isrc.iscas.ac.cn,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PNP: add a error handling in pnpacpi_init()
Date: Thu, 18 Dec 2025 20:24:22 +0800
Message-Id: <20251218122422.573466-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025121841-unwoven-twelve-e65b@gregkh>
References: <2025121841-unwoven-twelve-e65b@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3YGx28kNpOGADAQ--.11790S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgwAE2lD164uhAABsh

On Thu, 18 Dec 2025 12:33:05 +0100, Greg KH Wrote:
> What tool are you all using to "find" these issues?  Why aren't you
> properly documenting it?

Sorry for the inconvenience. I found these through manual code review.
I realize I completely overlooked the static structure. I am sorry for
my lack of thoroughness again.
I will document how the issue was identified later.

Thanks,
Haoxiang Li


