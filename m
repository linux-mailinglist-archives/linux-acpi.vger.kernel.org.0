Return-Path: <linux-acpi+bounces-9733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456219D5B0B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93B1B21F90
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127818BC32;
	Fri, 22 Nov 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xrd7DFQd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BB18B488;
	Fri, 22 Nov 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264220; cv=none; b=Eug9t5IGR2LQDmtAcNQwziq8a8shp/kl2oiXk/SuOM79LwWYBKWtCFRMsK62Skho1xo8ovSqSjzD9qmCKivGa/8/G38LtyUsTbUl3AhmRY/hMFB8Q1LZsbS8g98c6dLVsm5JZhPjCuTTW9YhhzM28JjtjbowQe6SbPpF4VIrNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264220; c=relaxed/simple;
	bh=JqQZtXK40acXy58QX2YIIWMwHGb8xU/r3bW9Pix5Ipw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMAuFzvL7/dq4WK+ZBqR6eNpG++oCbrNZEQ+kYfUhfoAygMVxKlBCY3P0OeU++OvWBVuK9eW+l8o67euhblbBGkUXYGDM1YgYvToythnMhmLkMAB6vRZ9+fdmSzHxfEs1Y/GQY6L3DBeHZARsW1IJnO+Qo3fTKu8W7IF33y5STg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=xrd7DFQd; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3012:0:640:8a85:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E2AB0609DF;
	Fri, 22 Nov 2024 11:30:05 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6b8:b081:6416::1:22])
	by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id vTP7lN0IYKo0-IIt9HvtQ;
	Fri, 22 Nov 2024 11:30:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1732264203;
	bh=5xXVJ5iVTPiPkoXzKdRU4pzuGZK7cFAxSxr+Q9wI+3s=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=xrd7DFQdB/R3YVNVCUsF0493/rygp/o3ZgbwFRr6UBDROXFOWHDsCeO56e5dVHJU1
	 xmdOoU77Yy641kB55DBMSS4UpfspANZrcZ6Xz4scL8FDRkW/pahkDJypIiWrw9N0bQ
	 Sor7ZlW506INGLhCMjmh6ek2sqMRbuX+xxr2wd/Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Robert Moore <robert.moore@intel.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Erik Kaneda <erik.kaneda@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired
Date: Fri, 22 Nov 2024 11:29:54 +0300
Message-Id: <20241122082954.658356-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was first introduced in c27f3d011b08, where the author of the
patch probably meant to do DeleteMutex instead of ReleaseMutex. The
mutex leak was noticed later on and fixed in e4dfe108371, but the bogus
MutexRelease line was never removed, so do it now.

Link: https://github.com/acpica/acpica/pull/982
Fixes: c27f3d011b08 ("Fix race in GenericSerialBus (I2C) and GPIO OpRegion parameter handling")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 drivers/acpi/acpica/evxfregn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 95f78383bbdb..bff2d099f469 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -232,8 +232,6 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 			/* Now we can delete the handler object */
 
-			acpi_os_release_mutex(handler_obj->address_space.
-					      context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
 		}
-- 
2.34.1


