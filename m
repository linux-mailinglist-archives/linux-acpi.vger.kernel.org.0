Return-Path: <linux-acpi+bounces-13393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2CAA5439
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB96987BE3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867125A32F;
	Wed, 30 Apr 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEMz18tJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652A1DFDA5;
	Wed, 30 Apr 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039198; cv=none; b=SjGe1dwWL10Za1+tD6/YPrlTKKB0D0FSmS68+QTtrXCjRZWdQg52byk/v9vNBpFVGTdm6/T94IDgbXrCm5ZX2Y6AwrcF4o0STKyUqU2yBc8OONk2hJzRN1gGk57/oB8s6YPuyCNPo0MwC7FISyhY82FKvtlQhKZU95hhQb/1P/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039198; c=relaxed/simple;
	bh=rYjStq2mtn5geEz3C/+mX0Z0g312KHiTyEJTwFxB9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BK8Nye5ydusD/uIEv199jAJFGcG/kBeSC6UZ469QZlLV+AcsUNc94K2/TvGJRv7BS2zPO/oqnVRI7yRaJ2rM+gSdjeGF2HSZf8LhP8DblMtXzSbbfAO3v669HdvH3WgNdgfZSmu3ZJw1g087LWOjx4EqrD94ZHwYaK34BTY6RHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEMz18tJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30db2c2c609so1253931fa.3;
        Wed, 30 Apr 2025 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039192; x=1746643992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYjStq2mtn5geEz3C/+mX0Z0g312KHiTyEJTwFxB9gU=;
        b=EEMz18tJeDY1n9ZG1jieT+6X7LSVZGq3zE2U4mxVBBjXdWdo1kCkxDni9LH7oPcPDG
         eWOOBjsjTdZcH+NoEowCAVEu4Lba82eRMOqQEhfStQcfw72K4p7gsHc/9EEueCKc6tWZ
         bGJFGFT3EFTUqHFF89fuiVScnjd7s/jJMRdaMECMwQaJ7lXRKogso81/TY5j4LuhiBdg
         SOeZ6WO2T90KNLt5Gd8E4rDCG9b45OmGWF+Y++qjiD6/NvTbUYFMzgnFWwsF5DazjCZL
         GaKBq3fO3bayw+wcxUVVd17dqiIEF0hX+x4ev4gzg1PGvcm//9+1SMffF6MT5A9K2Onz
         7WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039192; x=1746643992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYjStq2mtn5geEz3C/+mX0Z0g312KHiTyEJTwFxB9gU=;
        b=dJiaGxqlZYwSbBo2aOXo3DYZTxddrMiX+1ryyEyp6J5hbVFHecxx0Mx7bZxm2CtFuV
         /suB17G6gnT5X9yjZ5JpxJb5b8VlZ5/1woOIA/1WBFh6H9nXDGJdbL1gY2Xag3708xNg
         9evRqDHwzKlYVFyMLFp3hFFTMrcPr4eUZ223Qe/BwvOVI1Zk9juGEq8uBMGm1VC9/MC8
         SiYzVSEVDO4zbp+AnOajRr3Uo05oAYXUEQvcs5VcQdtv89nBtplnk5Wy0VjlED1fdTde
         qfjk/Kx8OE1kAk8l2CNuB8Rjq7vFP0hqI2xxgP3kLEjnHtrqYSkoRtD7cvuqLXiP8irz
         yKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUfNdSS1ElDXose9IySt3eVPM4Isj6/q+eqEixupR0pVYW8qe7xzJRJxIHGlDgoxTSWOg5idEnBGAmjSMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbsggp7pCq4sMm46t3pZWEEjUI1Mc4qbcnLicc/U43qKlqlwEB
	3St2Ya5qT7ZQ2SVlbAUhleKWPZBH31l3KyTp8tEMtT8aRgaFy67y+8CHPtw69aDhTzFFxspnzoS
	Yt5T+29zLLXXM1xAPrp9duGzaUt4=
X-Gm-Gg: ASbGnctKVpVxGrOz5AzisvB0snA2lBlNzsaVciJuzLPY6QZ2QPrWeh0yFZcPE0iowlX
	7R7G+kOEytXYFqQlBllIASLW3BGms/KSUmlSd9zeLQFmzKpzbT9pZRE8VKsrYqD7L6ppt26XxXa
	iwLYPeeg/Nlvvgygl5L+pOStW9NIJ/VC8pbZtOKQ==
X-Google-Smtp-Source: AGHT+IE1uQ++FjCkKhQJZ7cMIVgQBJMGgIRP1tpha+mSsq2Dm0WDNf0Bkn1ExNY4pud7CTYClvJ4erGm5XjS95+y6qQ=
X-Received: by 2002:a2e:ad13:0:b0:30b:c8b1:dd95 with SMTP id
 38308e7fff4ca-31e6a7f48d1mr18143581fa.22.1746039192182; Wed, 30 Apr 2025
 11:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4664267.LvFx2qVVIh@rjwysocki.net> <20250430185019.19528-3-tamird@gmail.com>
In-Reply-To: <20250430185019.19528-3-tamird@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Apr 2025 11:52:35 -0700
X-Gm-Features: ATxdqUFjAf8Msr1Cb51650ntnGmG2m9PfkVIDrtXiA26TOGYQ-ZYk_TJzVAhDNk
Message-ID: <CAJ-ks9kmwpf85tW_R30WmzU=fjB5p6+2vjZvzojsLuu3gFzv8w@mail.gmail.com>
Subject: Re: [PATCH 0/0] Cover letter only
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robert.moore@intel.com, saket.dumbre@intel.com
Content-Type: text/plain; charset="UTF-8"

Oops, apologies. Manually replying to an email I wasn't included on
proved tricky.

