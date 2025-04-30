Return-Path: <linux-acpi+bounces-13391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C772AA541A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012B51C02EE4
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53225A32F;
	Wed, 30 Apr 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghSEPHUl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A31D7984;
	Wed, 30 Apr 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039048; cv=none; b=KuMcpKOlrh30pTD8ltejBtr10uyBPXCp3yRRqOA9DxitnJd/1pPrFOxbplHgoaBxqKToPEDf7WgYC35onOBQpeldiH0i5GwUiEiKHfKoDCLFSyK4CJr6kGxv+eajBzgkS70sBf0hJwJ1yuz5Cx1D8M9MYpteJVe2s3B5IptMfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039048; c=relaxed/simple;
	bh=ths0W2TTwv0TWuQAr8i8phgvBeigp8y2ypCWoOLDDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vfzgcze+V8LJQTgdsFI2igu8W0G5t4cOLXqHIHM++wZSNFVSj0EVqLrXq37s1I0asWL0Px5b6E/dO0Ath5w0LV8gGDZD+iTaxzyVN5TuuDuphQ5FBEep1Nz9wH7wWftO0Av0sk8Rc9apy6pNcW2X0rhcgo7XOxrOKLk/y/BTFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghSEPHUl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso308236b3a.2;
        Wed, 30 Apr 2025 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039046; x=1746643846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ths0W2TTwv0TWuQAr8i8phgvBeigp8y2ypCWoOLDDvc=;
        b=ghSEPHUlE1BLIcts9acLdPQi5fr0o/QB6Yz4JaseaHC6YmcEXiGVkDKZLrdv+9OkCH
         esusY4l9KtT4p5AJMlxEG5a4qR1ooxL8BSEnQuwL3l/QJamUPWNaxwga2/m48nefZvqX
         Kb9fgbeYY94Xr9F3kIyoQ4vCYtFISHsrOzdn+TS7cvwIEROxpwr7JRxRDBbML4fi5zVy
         9uMHqinzs4LcH0McLAtei71yQbbYlAgNjXs7NbpLdGqt9iTyOxQegXa1QxsoUWOObUHF
         1kgGYPW/8xuxEuDTncAKsMLFRbNwIALCEJ/QKE8YxMPkt2tbGhwOZTWifSn6jG5zlpEV
         xUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039046; x=1746643846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ths0W2TTwv0TWuQAr8i8phgvBeigp8y2ypCWoOLDDvc=;
        b=F3P9FmhvWwgEWmCsuEarERXAygdyIrJ9xYcaWaXX0HDqOp+J98PCPqeQetdFWrA3yy
         p47Hn+yMJbHiLnY0TgRHr3O748XtwXX9oSibjQ0CLpVELQHlImx6dGbEBDBqREzOtF1w
         /jEOXAv3TOYbmx6Tzt75Gh+jTs7v5S7q3rj+xfFs1gNvHtqkzCPH62RhcFI5lQZBaT68
         VLEttHo6IvCzOs2akWJni5n1IKhuaf01pIINtoOUd0Jwo81Swfc/Qna6it5T8Rz0HYV4
         yLjBo3RrW2N1imhOpD1sv8Pq1VoS4B+UKJhb9f4jG9lMJ/6+uBTnwx3ddaT1g0ks52ox
         63KA==
X-Forwarded-Encrypted: i=1; AJvYcCUSoZti/1F1vLQdrxjioE4J6YgRQPEKJ4Y7RCO6c6kN5G22YbtJvxrnrV+y6Mo0eXbWenflYaEIOn5rRr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGRDCHBZGAph1fQ599d+Ej2bZO/cppZ4Fu1kOoOCNshnqzne6
	Sa/ULvYsXJJUHE6anXL2I5eVVbCm/4rQjfxIzUGP6LZrBF5Tf9cl
X-Gm-Gg: ASbGnctRjQgcw5EQvaKny6Ha99+FJMTLWzbo33MafHIxmXVlsY7XAv4PKZVk6drkRJ2
	BAyAJj7x/lLRyn/WiM7jt5B1eqUzA0lkX2NQkOyWCZGsuRY+LzdIsUUnNxwwFWprGB32yIJxTW7
	9Qq2sbBjphCc8yuabOxUzBxIdLm7gtaWpaRQG1rwakOnzeUFTnusfTFmSi0ewOPJU33vf/8W0hG
	Pvrsc2xwcLPINMIpd+lyzSyD+0ic17q0iXmEHi1ZJ5b17VXXSkQ8MaRt7MNrwbTPmcujO+7UrOA
	njxTCmWXHVbxqW1azLiVo0tSDLATgLbxgrYM/JtzKUhi1IeXMPV8ZGObowM=
X-Google-Smtp-Source: AGHT+IHpPYQnqKunuwc4ms6xnymjlOwUAVuCjvcQ+Y9VjVJ3VB4oaq+NTQCu3iL8ETzS3IbG/aAv0g==
X-Received: by 2002:a05:6a00:1382:b0:73b:ef0a:f9dc with SMTP id d2e1a72fcca58-7404775cc89mr94686b3a.4.1746039045981;
        Wed, 30 Apr 2025 11:50:45 -0700 (PDT)
Received: from tamird-mac.thefacebook.com ([2620:10d:c090:500::5:c4c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm2086041b3a.91.2025.04.30.11.50.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 11:50:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robert.moore@intel.com,
	saket.dumbre@intel.com,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v1 02/19] ACPICA: Apply pack(1) to union aml_resource
Date: Wed, 30 Apr 2025 11:48:39 -0700
Message-ID: <20250430185019.19528-2-tamird@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <4664267.LvFx2qVVIh@rjwysocki.net>
References: <4664267.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tamir Duberstein <tamird@gmail.com>

