Return-Path: <linux-acpi+bounces-6259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2938FFE0C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B059283E2A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A115B0F7;
	Fri,  7 Jun 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kMYgB91W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784262208E;
	Fri,  7 Jun 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749137; cv=none; b=D1pqlCBJH26rZKmgb0829IAGxTxwtE/jCNbz6vcKzfvj74dpCg/ToJl0n9/6tG9L+7fb1FO2M5cDHA2lD9sCIDBGXTTqz42oR+FPAm7aXmM0OAkyX3ho3wWYgvICBMpHNHG/n5Jehc+TAvHDPhwahcDTazegvVfN7sE0uvWVIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749137; c=relaxed/simple;
	bh=A+DkgWFqywsQJPc6O6LIH/uEqKwNeM/Fe7AFbx+bek0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zo9TvfgQiSaHOIz56w8aMKcQ7gt/Sq/lGEvHk8tOeHktYX3LGzTVCJRxZizBH5mbQ44vYjpGnW4kzme/+DoHu4mSpl3ueoAhR3Q+qFvV76ACjtNk036Fv0rFCK7Pgm6jlmKwUrYuCsES+4dP8id4UicTk+LAFflzwMkbe4H9TJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kMYgB91W; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717749133;
	bh=A+DkgWFqywsQJPc6O6LIH/uEqKwNeM/Fe7AFbx+bek0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMYgB91W3a1jFCe2NJEZ1tl56GB4B9eujeR3L3NE0vF2c6Db54DPB8yrU4knUUa+q
	 iIty6khh0Br6sjJ4OOOnpuzHuI57geuvFdxkE0mArnAw8PZZwmui5dQ9QjIzP2x6gj
	 aXVvkozB7G2diJc21MzAmlMpD0RbCFPI6TSeOXZpYK7U9cpQv9IXmHbmrksRR4py87
	 qEYJvHO/bHHIAeO5pYPuKTSNNGtCPFxwAurDTMZlLtiwQZpMgEYqu2wsJfVW9xYE2K
	 CTvbX9QBmy9Fy61i7KrZHWBl8RlVBO0dFjulVrYdQtK9eZv3LfH9+aEE4IXcL02tjW
	 Sv6T09U17Y8RQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C27693781022;
	Fri,  7 Jun 2024 08:32:12 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org,
	laura.nao@collabora.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v3] thermal: core: Do not fail cdev registration
Date: Fri,  7 Jun 2024 10:32:40 +0200
Message-Id: <20240607083240.115295-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <12456961.O9o76ZdvQC@kreacher>
References: <12456961.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 6/6/24 20:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v3] thermal: core: Do not fail cdev registration
> because of invalid initial state
> 
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass
> cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first
> evaluated
> for the given fan.  If this happens, the .get_cur_state() cooling
> device
> callback returns an error and __thermal_cooling_device_register()
> fails
> as uses that callback after commit 31a0fa0019b0.
> 
> Arguably, _FST should not return an invalid value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for failing
> the cooling device registration where the initial cooling device state
> is only needed to initialize a thermal debug facility.
> 
> Accordingly, modify __thermal_cooling_device_register() to avoid
> calling thermal_debug_cdev_add() instead of returning an error if the
> initial .get_cur_state() callback invocation fails.
> 
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> thermal_debug_cdev_add()")
> Closes:
> https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Tested-by: Laura Nao <laura.nao@collabora.com>

Thanks,

Laura

