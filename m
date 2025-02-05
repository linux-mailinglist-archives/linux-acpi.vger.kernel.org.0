Return-Path: <linux-acpi+bounces-10899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C03FA28BF6
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 14:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8757A188267D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32634148838;
	Wed,  5 Feb 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RaxhFnAL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8313B298
	for <linux-acpi@vger.kernel.org>; Wed,  5 Feb 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762806; cv=none; b=cFBsDtpI7EO4CuujCzW0FRRM4808/7it9tLbPwPx6GUH5H/d6v41rhGqbsJf62jslK+S30x+v6aJcTGLnULkX+1L1RjYUtH9MACrdKosM9jtfHRRdhRs+BADLkRoe6bvIxCdgFE+1VKhKjJkXzGqVEGUyzkAKILl33CRfPTaYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762806; c=relaxed/simple;
	bh=Ve93mwsrLnKqcrL4b+tMX3AMLTjOmyr9pkgOW1Gk9IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2cZyS+9v3pDd/k8NbgiZD+0/XbCgseG4SgGw07rhIsggyN4oof20qrbHup+KosIVEFr6xGkcu0BZekEDbA0buzsCUK7fIGi7k1l/FSdkSw3uwmwRe7ssR/Z2JoM5RSOmQq2wDb8LBoRB6ZEHrkwmimEKN+/Gr2afGZ+xdFileQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RaxhFnAL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361815b96cso47272875e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Feb 2025 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738762803; x=1739367603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0I5UAPNb7leRiFQPea3Mwu4N+fMvAxuwxayNKEzT8o=;
        b=RaxhFnALX3PPMurloh4Yy/tHpkdiPrvrZ7zhcQx4FEeQJWQTyfFduEq0YXhwb2wI25
         crCFuBnDLMaKxhgvNWSJz7K94Q+si7zDCadlhWInYy59ibs5zjt+3uoHB2a857BConzV
         uXyBUAt1qzTFo2RtcniUIPW+b3ScGaVFqGtHaFxRvltR19Bmo5YlRAKYrjh4UrrVj7nq
         UobYr6Qogt4BGD4bOebfKfEZYhEB2L/D6O9H1tsHFDiPf+Ee5Ytj8w+2FQBVIH/oZ6/Y
         CITsGQ2RGtDNtYazPHLwJusGehqjti1I15pkLiKUjJWgcwTCqwnO8LgO6JKfA9LwXzxH
         nDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762803; x=1739367603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0I5UAPNb7leRiFQPea3Mwu4N+fMvAxuwxayNKEzT8o=;
        b=LOJB6xrTnAVRa7kKhqSgtMUrMuX7tSAZ6j+CUBCZnjlBMjNeu71bVp0S7jehaIukKN
         T66o0bTaKDKOPUYqNSnZlc6szzd3aTX7l/q3aR5B8qdJwNGqrA2qgmYbWD1NbQFBRKQO
         fcEbAv3/ZGfWp3YgYzaX236vFv8Fy134y9vyYPypYqzqOWg0Z0Jis4h22rl94ASUK8UJ
         BVZDMMm+lUJkkSTPZn+7slP/z+8OVYES8Jixum4ZRCJyaAHV31MvJvnET3Ja1wQFZ4Gw
         lbBczziwbt1y7Rc9HkVoDW92DQJ0WP5WDs9rZayUyDyyu6k4VxcWsI7znM6mXHKCsfyo
         PT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUq1lhGd2mXoChj3kF679EcYeY4VSFccr3p0BwRXcaSjvm5575K33u8OWuMSl+ri2XHojG2+fRh4xth@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46/NhXPVQ5f6DiloYcZbK8lj8gb2tj2AnGgTXoKYnSA9slET9
	3ve4Opx/rBHSLOf9k+IlCsn2s7brbpzwsiFcrSI6b+FDT2I4dbcW1JgdN1Jj4Ks=
X-Gm-Gg: ASbGnctwJS4YN2V/HfYMa9sn1YeE1+gAb/ONXsVW8wEge5jKcfR8KU369dTzGAHqaS4
	LSB5/8S0QPNnsrp3LEHf+eXuJGZkK8JtfTV+lZY1nVST1FIhKNgyYBqxS4ct/Y4HFbKKpkP1MD9
	yuORHSCJjue5/vH1En9hHbNx22x/P11090h7gRKskiB4rz7vHHwtSHpbp6jai9dVj8S9WZixSY1
	9PrKzHoeswhoGsmswtOmHzmCuMkjsPI9XI8PSwKya4CKorFIQPeYUGE0Gq/A/CULf+jH7X94SZe
	klgHZictYnYzOqM=
X-Google-Smtp-Source: AGHT+IFIv1roL1rPhbpQ94pwMrGgfqFC2BuKj9zjxmrwhOwb5I8/JHDgxOSRNY8p9y2VWAoPPehu+w==
X-Received: by 2002:a05:600c:46d0:b0:434:e9ee:c1e with SMTP id 5b1f17b1804b1-4390d57762amr23467005e9.31.1738762802750;
        Wed, 05 Feb 2025 05:40:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3239:b668:f15e:fed8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d93369fsm21974185e9.3.2025.02.05.05.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:40:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org address for ACPI GPIO work
Date: Wed,  5 Feb 2025 14:39:58 +0100
Message-ID: <173876277709.18360.13170516746376335320.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250204114515.3971923-1-mika.westerberg@linux.intel.com>
References: <20250204114515.3971923-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 04 Feb 2025 13:45:15 +0200, Mika Westerberg wrote:
> Switch to use my kernel.org address for ACPI GPIO work.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Use my kernel.org address for ACPI GPIO work
      commit: 59ff2040f0a58923c787fdba5999100667338230

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

