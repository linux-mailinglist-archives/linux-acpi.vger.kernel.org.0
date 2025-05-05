Return-Path: <linux-acpi+bounces-13473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC9AAA24B
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE44E3A2C6E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C482D86AB;
	Mon,  5 May 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/4QMuT8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C82D869F;
	Mon,  5 May 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483669; cv=none; b=qgb0rh+fDsCORsmekv/U9mWP9AoBkZAUD53FBkYuF14ArayHg6jWsKDtCiUnA4c6TOklFjeBUuTS9sceC9UgYmyLqUUt3dSfCI+WvMJcXqxpKYmL4Gmzve0QXLxXCPKzLmqXztXDk8Huj2DvtkIM2f1Wu+wMFY1k7Ka1liIyyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483669; c=relaxed/simple;
	bh=1VbaWWLdA5HmNjEIviEi/XhdFnVk+gwnKiAHhTR9D7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h02gnT9682FMcHzqYpLfVGvVvD7mqMA8gYnELJ7mzY0SbIjHhxyVPNDUtgveHn+dwxoD3A3UM9ZMyqzgCCvQ5JWxG3qnfgcpDvUqz0LuQduqnK3QX2LWwAOA3ZgJuStMpmkXeGg7mCdWNJyw8mWcjN2XNRlqgHxz42gUMbqmhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/4QMuT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5250C4CEF2;
	Mon,  5 May 2025 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483668;
	bh=1VbaWWLdA5HmNjEIviEi/XhdFnVk+gwnKiAHhTR9D7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/4QMuT8RmCfm78MBzJQRWxAb/CTVedWFJfVIt0sVXjw4ntuyfZydWpr/WNOC1Sl6
	 KOImvwlOjZxQsrG9xNA6amqNrD/eHof7QoHJ4A0s0vfQWOydU8hFZN+93hcczjmpFc
	 EdZ4GgzJ3AJ1Nukcp+WAXzPEhsx3VaN6Otb9aZYHxgrLJVgFm4Aldw6k5Iu/lYyJrW
	 eXdnc6P0IL0sTyF/S4h/o/61dUcmBU4eFhiNvWLKJcDLGMwQmInjg5hkZkrf2tGNs1
	 RBXcN8/1NnyEyJ0I72Q2X55K1UZ5e1H5Kj/S6PVPrNdZ4xjNv6gJn7rKPkpNIGShSV
	 QX/AkoHZ6s3cQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 170/642] PNP: Expand length of fixup id string
Date: Mon,  5 May 2025 18:06:26 -0400
Message-Id: <20250505221419.2672473-170-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 425b1c97b07f2290700f708edabef32861e2b2db ]

GCC 15's -Wunterminated-string-initialization saw that "id" was not
including the required trailing NUL character. Instead of marking "id"
with __nonstring[1], expand the length of the string as it is used in
(debugging) format strings that expect a properly formed C string.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
Link: https://patch.msgid.link/20250310222432.work.826-kees@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pnp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index b7a7158aaf65e..23fe3eaf242d6 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -290,7 +290,7 @@ static inline void pnp_set_drvdata(struct pnp_dev *pdev, void *data)
 }
 
 struct pnp_fixup {
-	char id[7];
+	char id[8];
 	void (*quirk_function) (struct pnp_dev *dev);	/* fixup function */
 };
 
-- 
2.39.5


