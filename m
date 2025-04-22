Return-Path: <linux-acpi+bounces-13189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1922CA97470
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEC441D00
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265928541C;
	Tue, 22 Apr 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dlI8/4pc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E655A59
	for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346126; cv=none; b=IHXozMeqTzIPWHQltxcQxmcWeBQ5lrGAT0czR6QhvlKr7g+f9ySoPSuGERh317koMk40ewPiDt5g2l0w1UBjjWOFygvYtuYFojupZmuci1/ZhoZanQFz9aPCzsml/NHpkgA7PN66WO1omXMhf7DmQAEoOSg/f9Qfv170bPG/obQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346126; c=relaxed/simple;
	bh=o6Rvwt3bk2muPLUKaZfPpXSAbeEMTyhE7PJSmQryzEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDthD7cW60TMyJ0pDB9vJYWHBiFdn2IH3BIn74zGbaX4XHYYjUcV55ueDwZ+KARCK+0yzFK2ev9UuxBCxb6mrfCq0FkRy8nDbIrNp8L3GTIIfqRahOgR/ERXu9vgk6b3jFEgACAR61FhrNKvg7XnYMThWtN5NcSXZ4WGfikjF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dlI8/4pc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so8314263a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745346122; x=1745950922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3ll63VqG9vTlmspUuUyoyOk/C7C+03/O1xhGVXIUMI=;
        b=dlI8/4pc8V3Omzf3ZvnC33jFy+GQmLK2bOcPfczsa6FdJQ3BABUtVmdoMOPG4e5OOI
         tckNNYhxEibfN9sZlBSz3vDsqdVNeZ5Euc8OCnVm2h28SPOaN9g34m+blszFO9GNe3A9
         QiHwlSg+g+6QTGKuOxIUSD+UgGMTex0chDxeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745346122; x=1745950922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3ll63VqG9vTlmspUuUyoyOk/C7C+03/O1xhGVXIUMI=;
        b=jsVaGvopeQN5WYdoYjb8nXp3AecMYmbJrI2r6DesWtGEXWH8B2SNz5y2DTMkZDymas
         rFXOOdPjK7v4a7YDXAayK+GsLwQC+WdYv1iHoVDmvStHo0uvryE6N5LVotwiRCKdzxC3
         +SluEwSzCcIhlnTo+0PqU3T9sFNcwQkeywAoZz4zfsaQQ+adMGQ1EErDmLh6NV9ynJYC
         Eh2a8M6/R9TSxzONkCe0LqXtvQVYfMkKeXRVOZNQVLwiWemQAcA49GsEtDLjIvOkiebA
         h1lzQM03Mspe2kA8oqojT+Kgb87V+3A90aRO6e4pnOtKvm/05u/Qzvhj7vjbaxS3JYT+
         cChQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ1gnOv+A5Iay6CVWeMkd0FPaRtQyYmJ0aldcZfs7FBmWPlHlJb5syOfLlM75coOXbya/0uwE7ntB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2eZNx/YS4APcBcpCFipn+n9LfXPUCBi/89c29l58vtZNFz5e
	/c9pfLYLPUc68ukW/nFloNaIVZXA9YuwCGBG+AcEPffCVPWOr7ZclXrTdVuxg2SiHzkeuP/ptHN
	GVsU=
X-Gm-Gg: ASbGncuMdpFXMUlENYjohIZfdZ5nF6DLWcuMOLJjtZY3a7hYvaFSJRsEzI2zcTCpcKn
	GRpIjGPg36ao9hN4MML4d21SyVkIM0YiQeW7M9zPUHbsUQDyX6J10pTPM2O+YKw9WfcM36q86U6
	1/Wnc7qEJIJKn0uCUPgnEnPKJ8XngbuTr4GJoSVx58C/72IXLnZheCTQJxViHAPEwra1/kdFo6V
	+6BzJHbX7wZJNksnmUPQnsMq2ABHwquAiIe7ZUffwoeLan4BYAzAAt9tp5xVpeGAtX3HZ27dG1n
	H98aFQz70AqfB5Y11asatFbog660yvcoAeLgsl2MvUznJRh50dgalqRiUIc0PuLrNLHza0GDjJo
	vDdZICTPldobb7NCGqxRD09BDSA==
X-Google-Smtp-Source: AGHT+IHmxg5jAByl9me8ICrcUvtRYWdOUdoLPp9BjMQUupQDTfh3S/IGCrMLVSTnL4ISADjS2rZjlA==
X-Received: by 2002:a05:6402:1ed2:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5f6285e6a7bmr14153545a12.25.1745346122342;
        Tue, 22 Apr 2025 11:22:02 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62554b300sm6053157a12.6.2025.04.22.11.22.01
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 11:22:01 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aca99fc253bso786326966b.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 11:22:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdHWzA4ucA22B7uwt/0+8GQF6zRKIYXuttEWEeAzFhce9BTWssXykaHVc1gBCWGlHUqidLdjFzUVOk@vger.kernel.org
X-Received: by 2002:a17:906:dc89:b0:aca:c7c5:f935 with SMTP id
 a640c23a62f3a-acb74ea8f76mr1249698766b.61.1745346121461; Tue, 22 Apr 2025
 11:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3c81bdf-29dc-4d57-8cc7-138cd16e9d5c@oracle.com>
In-Reply-To: <a3c81bdf-29dc-4d57-8cc7-138cd16e9d5c@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 Apr 2025 11:21:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3Q+U78dz7M6R_qzbH41N=3h-2-KAw8-DY4a8vpDhR-A@mail.gmail.com>
X-Gm-Features: ATxdqUE77Jwim4HrfFpj9Zre0DTQC3Qu3HHFOhYdf69FlBWE_EOrxga_NS91jGY
Message-ID: <CAHk-=wh3Q+U78dz7M6R_qzbH41N=3h-2-KAw8-DY4a8vpDhR-A@mail.gmail.com>
Subject: Re: 4b4bd8c50f48 ("gcc-15: acpi: sprinkle random '__nonstring'
 crumbles around")
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 11:10, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi -
>
> I'm seeing this new warning fire with v6.15-rc3:

Yup. See commit 9d7a0577c9db ("gcc-15: disable
'-Wunterminated-string-initialization' entirely for now") right after
I made rc3. Oops.

             Linus

