Return-Path: <linux-acpi+bounces-19466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A4CCAAC35
	for <lists+linux-acpi@lfdr.de>; Sat, 06 Dec 2025 19:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FF63066DAE
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Dec 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E927A460;
	Sat,  6 Dec 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOOKOjGf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D3289E13
	for <linux-acpi@vger.kernel.org>; Sat,  6 Dec 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046084; cv=none; b=ncDriMF+8THqmIJ+4cKqiZbfWzuhRyDO+lRSeYrrw/VnDYC3mSmKCkymerepjPWPN44rQZhkVWhv13pbmLzUElu1RLhHQzdmRceXGjn0A3GZr6zVLZiJne0aTiphqA0qtrw3XO7RqJELGrtyH7aAEDNEufshKMEO/HNuyJOhJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046084; c=relaxed/simple;
	bh=kA4hAN1sHiKFKheGE16X/PUth/xQ10ETqni3kNgL7bE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2BxB9tjutXZv6/YPTYj2fd4rDTazXQ2RWve2IQLdWFiZ7eQUGEED58Nd5nLn60hcP1zrRwQnGlx/p2WmuHFU8uMVyUXYpS8Jk3rBnuL3ebjyqk3hAJBSHQNH+UNfltIZbgEJeTJ6CP18O1JQgmWMGEITGzejaPl2crBRRKv+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOOKOjGf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37bac34346dso21132991fa.2
        for <linux-acpi@vger.kernel.org>; Sat, 06 Dec 2025 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765046080; x=1765650880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvEboDLvR2gzipynR26Tv9n7iFvwIWdMUwKccQoCWtg=;
        b=MOOKOjGfNr3345ovEuZTT604fL2AdLF5TigrThXrgl3KCwX7nC8Rw/ALDiJylQXD4U
         Zw3o/fV206a55eCK8FkJG3TtUjWG3Uyr99bQLX+5Q5lB7lXIGXcrtO18OFzguVN9aX+p
         nHlwzbpFh18XnBKcDvai+jOjLSfPocGuHwypPrdBwI57c1cNkza+BzNpco3Z2ZKeWSEZ
         4ZqsN8S1EXiOw1jzjXWo+GhLQYw2t+OoKZghsShvgQusonGco1g3A3iA8TicAUtMo60F
         GP4PYXq3ovhi6A76uwhJO5B+C/xiXD6FQJYatuToKOZoKuJz4rx/SritkBl8czWB1KFb
         xeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765046080; x=1765650880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvEboDLvR2gzipynR26Tv9n7iFvwIWdMUwKccQoCWtg=;
        b=Vbf14EJoZAgyaHU8QgcldxUKP/F3O86PE7qPh0r95GCG7jwmAxpNijKLUgIqYAn3Wz
         7zFAgx+adD6vXZkaZcStZwD6BGpRMG3rEs1+RNzujaboKXwzyWhQX7fUoZC6QTUVQxJX
         7G1T3QSrDMq2XIGRm+uKJT0fCuLofWyCLIvuWyjDaOyG/Q/eosKl0DwSzS1yALAogmut
         RjSjgGfKMqJ1Rwz+vYix8+KBcoaDbQ6/3r3EQQuiMeMT8a/Vx0cp1f4rnGjRmVSPgDWc
         xvEWslHrkTB2SlwEK92TUy7GMTQRERR87Y+dRDUIi7g51DNnVY7lg+vDGI+y6KaxN+qx
         ndyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/QrYpaYiE3jx188/Ml9R/2IhhifNeeXX1KPJDQPn65kn8z9Q68u18uGDpbcx18SVNux+4SJ9x5cwv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgr1icSbz9Gng+8P5Q53tCbVtXNBeenavE8B1Zft2jvXdQW35G
	7Da76jTrxWwfQzRZXPbVF2I+7Rw91OTQWz3XDYTZmdxYFtE4A7sk5ly9
X-Gm-Gg: ASbGncseThrhYCFCX2kdxxGZ+AiIp8FZJ51bivqu9o7ZRPDYP5VTeZ1/uflCRc3H88/
	aNHN28Xj5Jjfj48k32K9CvL31isA7rWEUJdJ4WurHE0/zqcvw7kQ7Lukn1XCTGw7qc45IWvgeGW
	kHx1Jrg9jbwSfFG2go5Ar0pVAqUxubcgtVtnAcHGyuJOtjfXme4vZsSiBdDT36RrodH9DzRRkAT
	/aU6sm2M2bdEfh/Opk4LE/wdquW9oNHE4CwE2rPB7Kip/kxzaYEEsFx2TyVVTT4er+FSWd06jKv
	2KXoDdTCcXYm7C2GTDkBWOO6vqMnbrDH+GFx/DQBDzU5Jh798XwN7QCHo86T5C+G7FQLNgSafy0
	Y2HS9EHgCjIlaMuH7FczZcjmR3tP4K3SSm9xGLwHy0LEphQMF7oPHEChL0OJoLNp2Hy1PnCVc/6
	1kWFMvTSpO
X-Google-Smtp-Source: AGHT+IG33E69bsxDqP4nGkx72DrGfYjPjJ2GkqS3YfyfrVavZ4K3jW7roYUUcqQB8woGw6GG0Vqd+A==
X-Received: by 2002:a05:651c:1546:b0:378:d5dc:17c2 with SMTP id 38308e7fff4ca-37ed1fb8099mr9884041fa.11.1765046079701;
        Sat, 06 Dec 2025 10:34:39 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37e7060f2d4sm25155801fa.40.2025.12.06.10.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 10:34:39 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev,
	Dell.Client.Kernel@dell.com,
	Mario Limonciello <superm1@kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH v2 0/1] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Sat,  6 Dec 2025 18:04:12 +0000
Message-ID: <20251206180414.3183334-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-patches/20251205230724.2374682-1-safinaskar@gmail.com/

v1 -> v2 changes: changed tags

Askar Safin (1):
  gpiolib: acpi: Add quirk for Dell Precision 7780

 drivers/gpio/gpiolib-acpi-quirks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449 (v6.18)
-- 
2.47.3


