Return-Path: <linux-acpi+bounces-18220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C1C0A457
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 09:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF64E189B
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFF256C84;
	Sun, 26 Oct 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbSMgmSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AA227EA4
	for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466367; cv=none; b=HW2UoIQzeW76e28maXElQZuzi90bpUhry89ptKaKL0QvcRf27idAOTiJcgHu0Qx7ppN3IVmKF8FIQxLTuz4BysKm1SZHbPKLDidhiiIDUkXnodckUkvA9JtxrRKD3zwsUENG9b21KIeuCR6lg7LbY5xqHsSAEnGuZ9ThkDTjYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466367; c=relaxed/simple;
	bh=NxNRdz2kuz1Lcq3kjc00zlm1uiFMfJ+3oQgiIquoeWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQx61laxRwkp7bofBHGcVr1T0ssncVeA2ZPQbZkm1NS/i+YhxnLauFpXP1ZN5Xw117YN5JvIwsb/qTcHP79Zx68DzC7kdXct0GTtcuRcImfTiFJ6Z273p2zOVFSzJ4JogOKcN3wPTRUodf/vupcwvflNug1AhLwoGDxOZ+Mf/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbSMgmSM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so3382951a91.2
        for <linux-acpi@vger.kernel.org>; Sun, 26 Oct 2025 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466365; x=1762071165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZv9rWuJDtiDJIpWUG6ZeOUE94UmXgPwVE62OaqiiqI=;
        b=MbSMgmSMMqxpBnCnQAjb/QhT/jJAwUBHLznfRwR85ti2q90+HjftoxyfU7AJ7qx+yl
         IpOQaV1vb4QM/JTuk27kpFtNS5jbgQW1xYVa/WYitjjsWERvz+sahHUOf6mpiQkBPqSA
         Ji+vh1i63K7rLN2SyfgLCbHV3wIR8YmZAnAIKhwB87v3LxtDMYDD2J4x/WFa+v3OaQmE
         1M9UIC6CyTv8Yha/CLtAIrgntpehkQezYDK7vozc+sc69fl7+KsMPFOGnuQw9FldHJ4d
         fZslJtZvD9G3gpN9W+H9EiV9ptdP1Jb6bcQ0gquSh4F/4nTB1VycWpl6rUnpg+UcgrgG
         4jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466365; x=1762071165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZv9rWuJDtiDJIpWUG6ZeOUE94UmXgPwVE62OaqiiqI=;
        b=RqRTrdj7L/hrMEswmpf97yh+vkm2MwSQMdvYsDgLuFIkUzWkuFRwn/exTcZH4hu0qz
         zHesm/L62qjqYralgxFPghmyxjsM3cOif37lr96flSCjIxuq/9fKetfCj7gF1YuPdPCv
         k9exMxmNt171obq3s7+PIZ77S/pWpNcwB7E9DrhsFse6/zhgbDHzjQMaz+NzTOQCTolz
         vYX6x8rlwgm2cRRvRbIrn+xipiTMOFKuit6BW8FMfVT2Bwjw33naGTab4S/uudGbGdsy
         x5w0uuPosLmEiQogfjTjWpeKlQfDo7Rz9EWoGYe0/A06pDkhuep7Grxje94H8vtfgDfe
         OmEA==
X-Forwarded-Encrypted: i=1; AJvYcCW4MJXRLLqUO4YEf80WtgOKOuE/8jdbRK01Y0f+FlGDGKI33k50Y7rMnt8vwu0AzWW4yyIlJJvZzqD6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsfoP0v7WoxsI8j2jcNB3PrFuzXUHwCZ0rj8OhSFLW6SLoVJM
	6APtQETU8MP0ugh5XbIw9OwozGOWKYY9noogZ+jp0eianCVjtDA/xD5M
X-Gm-Gg: ASbGncsO+x4K6gO0PRIZo3fwdTVu/2hqZemojfP3hdIvxK13G8cvRsh8y39VGBFzLLC
	TggJnOd8Ac4szZfNziaTaYmEatPY3ddGWsdlMuB+dIltd0FtbtB+GC36hYIB9oAtTNVez0ABdM1
	BC474G+L/oAbyaGCV0w97QLQX2XBWp3YHx7k0OQSVlHzX6LGLDZG+dSLTbxfqEI3dMhF1fV9Dwy
	hYgaOTfZFzJJmRP4ZW+Tp/jrXYM3ywITwYtkEnzSW/Opz1Jhkp1rRM09w3A4HJQIffjFIMdqlv4
	ZjLAmeoXIshfrhPZzSOKcR7b9beWQLvQjTfYAnoRqUBR2vldh318bjXWU+cR7LQ8Ba1gaYvclCE
	H0opUgx7DkUTg5gX0Q1qn4ZAvIghwHgxkfleKJ/J/6OYrcjKFSZ/COtBBZTRU73brS8aZt/VZAJ
	Zz3iRRLIouBdodRFb6B9+YibSPCWoimhU+fRVQHK3KAo3phOcH2Ba9jS8R
X-Google-Smtp-Source: AGHT+IGzPsm30Fd8AKfchIORpRn/v/MRrF3xbYiFaR1pMFQjvxS+JL0Mejj5JuhfnPngYzQEtIzCjg==
X-Received: by 2002:a17:90b:4d0b:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-33da0fd264amr30507244a91.36.1761466365050;
        Sun, 26 Oct 2025 01:12:45 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:44 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] Add extreme platform profile
Date: Sun, 26 Oct 2025 01:12:37 -0700
Message-ID: <20251026081240.997038-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "extreme" platform profile mode and uses it for
the lenovo-wmi-gamezone driver. It also prevents bugs that are being
reported by some users by switching the current deny list to an allow
list. Currently there are no validated models, so I've removeed the
unused quirk until something is added to avoid the warning.

On some Lenovo Legion devices there is a thermal mode called extreme
that corresponds to setting ppt/spl vlaues to the maximum achievable by
the cooling solution. This correlates strongly with an overall power draw
that exceeds the DC power draw capability of the internal battery. This
mode is stubbed in multiple devices that incorrectly report the
capability as supported. Previously this mode was quirked out for known
problem models, but I've since got multiple bug reports of additional
models that cause issues. Additionally, this mode being mapped to
performance when extreme mode is detected as supported, with the actual
performance mode being set to balanced-performance, has led to some
misinformation being promulgated that performance is always a bad
setting in Linux for these devices. There is also some confusion that
the mode labeled performance in userspace, which corresponds to a red
LED in Windows, shows as purple when set using the hardware extreme mode.

I'll also note that as the hard limits are refreshed when on AC or DC by
the ACPI notifier of lenovo-wmi-other method driver, no special handling
of the battery is needed for safety limiting this mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (3):
  acpi: platform_profile - Add Extreme profile option
  platform/x86: lenovo-wmi-gamezone Use Extreme vice
    balanced-performance
  platform/x86: lenovo-wmi-gamezone Use explicit allow list

 .../ABI/testing/sysfs-class-platform-profile  |  2 +
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 18 +++----
 drivers/acpi/platform_profile.c               |  1 +
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 51 ++++---------------
 include/linux/platform_profile.h              |  1 +
 5 files changed, 21 insertions(+), 52 deletions(-)

-- 
2.51.1


