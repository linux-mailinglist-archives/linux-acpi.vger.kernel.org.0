Return-Path: <linux-acpi+bounces-19589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B892FCBEAD8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B562F3069027
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C73346A5;
	Mon, 15 Dec 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="H6FJAc8X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367433469F
	for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812332; cv=none; b=BuJO2GjLeRfWWzhOxnGVK9w/6MIavqIm8gX31YgNbfm7n+p3szMmSv2KWd7WAcvRUuV/RNGL3LPq0Sh6aC+Pavp3EZbnzMbun2wNcyRw5ccxJfFQzgCKd9weXRljuK/DIYQRb8KdC3uGWt8Ni/y3+pfUWFqVCfLy2NIs5ZR5fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812332; c=relaxed/simple;
	bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4QimFqbkXVG4tjiWJzSrMPL7904vzYrLeFf7u+8dxiiFljDpvFBloWws0G3BpwyH9pXA6GjehJ9oxencZE+qNiHgCipGBgXBlTS/JejIgTLbReY9N9/4dnltNF7ccMLbHHkHszej4A2neSih17ouFu51H1AucrDrYzZxYaOaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=H6FJAc8X; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3eae4e590a4so1833366fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2025 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1765812330; x=1766417130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
        b=H6FJAc8XM34CfT5y9WJgYJy8xQdV/Evi5kiJLZWMYgz9J3zDpA12uF2ti2IaB1RjE4
         rrHZ7k3DX8XGJHR3LCvu4WaIMFUEN8Vp3PAXt7XkgKgDOv97raB9pvT5dNfbBUZ9dYMO
         GmwrzAxou9AnPK/s3QrFatz4BA2Pxjm/KiTu/6a21RePaSLd43DUz+gySUCd4UWwE3QT
         LIe/MrfBjdsdIHw1rjwEnbUT+XVCtH7csj29QPXmPDq+bZEfUL+FgHjeuI9OH/AfyjmU
         7mLs2IA6rwzkk3DrvvG2UcmaN0fSRPHXHDFLF+OhiQ5X44BO5m6odGX1Ny1Sjbhc7680
         5eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765812330; x=1766417130;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6TXBvjDh6qgcaWnx0SV8owIsLEZuQUARmz03l/TRN4=;
        b=nUkXlU5e8TiXk0IPIFgZIUi7f2iJoGKquuo7EZzjX58mSiN1L+EcemUx+cdC9Ft0VD
         t4/gj1CeYdTrzl1A1HFD9A4tYE1shU2sFGVbTnsVC4C7OicoQq0Q/ZUnN3hYIzcCcR/y
         4azu2fli5sHVuc1IPsSBRkOvmZklyjqLQGum0LcgWhiEXjiU2XpsZP/6NPkWDY6eIUqK
         ossZHgPOK6zCIEIcZuo+qRs0nGFShR60SwDRrlUExPEYhkKdjzVQgDOvmchm75VVrjho
         h/xFCns2DofnV/yVD6quQHSPrwzyx4J6Z19gkNjR74YOrdVprr+BQAjJH0FCby08jLvr
         ZPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpMcYkaZcSu/VZk0aZ+6yGdOYVlLX285SpMddIEgb3Jm9//kBkYIf+6vzAgevwEk55G3SUbSCLeJ5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3yMPzyOoKnNskF2EtTq6KUoaQ9kcius5Jx4zLiGOUahyK4OJ
	lftMS6TQTPpCwf0+bR50kq1twR1AWZjUBcXDQdMOBV4JcAt+JpZaYfoyB0Ijy69tP1l03be1s/N
	/qS6l
X-Gm-Gg: AY/fxX6RYS31bzNwYHxDpXLipCiTILSGklkeI79FDNZPOMP+zJTnXT3ldxQTndi3+W8
	ZUeUTYek2cjlXzmv88z+RKcnhO1wlheG854NLYTdGrzQ8uCrcJ6Rd0zy+syPVjtncOseOGkXDQd
	9xFesdFMbdw0u4Bg/WF0ApCOIRt+/8Eu1D5c93kWt2Q+uGCK8XSUAA/2fGdJ7va00EDQc0yPvdB
	blOj/CI75jrD+K3ZIJsq0S7p7C4Z0lnX8H2TJHex7NN71m3IN1JAaueTQJ2sjawcM+dBtz8z2sR
	zQkWMD4EXgJmqki9LqKQ8f/4vyCCiWhTY6qq3Wyr95chSBJ8svm40XXIyLwK4Xq8mKLfydMxIWJ
	8xqklRZ6fCRQADTeWptruJ5yCgpoHOP8AB5zyuW+UvmHR9DQkGgfeIe+cUZuW5BGpJHRE+OjgbA
	sGfAZWJAkKkwUfQqWoYw==
X-Google-Smtp-Source: AGHT+IHgPOrTRQF96zNhkM8x9pVuVnBQeIOdwAMQvt+xZMsAf4Jl3TGl+PrLSZ4K+eyqWUAooZJ3oQ==
X-Received: by 2002:a4a:e905:0:b0:65b:31e2:2e0f with SMTP id 006d021491bc7-65b45284858mr5277127eaf.66.1765812329818;
        Mon, 15 Dec 2025 07:25:29 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf8f:aac:6528:d0df:8e4f:ea9c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614b7c66fsm4718564fac.3.2025.12.15.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:25:29 -0800 (PST)
Date: Mon, 15 Dec 2025 09:25:25 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, mmikowski@kfocus.org,
 rjw@rjwysocki.net
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251215092525.6ea95739@kf-m2g5>
In-Reply-To: <33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
References: <20251214184507.21f95134@kf-m2g5>
	<33fc5ba96b80f1eeb69777822cfddefe64100540.camel@linux.intel.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 06:16:10 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> This data is not consistent with the reported frequencies M-TEST
> frequencies.
> I need to get hold of such internal system with the same processor and
> check what is reported.

Thank you Srinivas! Please let me know if you need anything else
from here.

--
Aaron

