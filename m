Return-Path: <linux-acpi+bounces-5988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4E8CFE32
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 12:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4E1C21296
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3713BACD;
	Mon, 27 May 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjwLXn6p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182F79E1;
	Mon, 27 May 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806228; cv=none; b=FpconmhDoEgnqGzSPoryyc9EfU2ORJPOK9T2B3wp4SsRJZnAUsV2mZbvv7RDmaV9jeHUDtB7/l+XQAUM0VZV7GGJth2MDnWHUtN8yEd0ULuK4kllkpRtiZcVqtiOWnuAnAQ8ga45NEH+9r73d6e1dBn3hRb5cyg10wu2Ko+W4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806228; c=relaxed/simple;
	bh=s2RFCNIQELf5BIroDDeqZxI19isVpFZDp8clQgSgR/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTt7J0sgbDR/nh6OmVTiRfdlXtHxCGXOPHtsH5vyrwcoa2+xc4l9Wc6eTWxWATQTJoO9NP5bbO0XeQHgXiL7IqLvL/6IhkOH9OX+JQlhvhM3y56B4XKvxKA9ceR/PxHunqgnWHOaR8fYnZKdXkOGMOqhlax588hexb0clFRgivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjwLXn6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E712C4AF08;
	Mon, 27 May 2024 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716806228;
	bh=s2RFCNIQELf5BIroDDeqZxI19isVpFZDp8clQgSgR/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjwLXn6pwdyZuZKn0X09RKT0yo2tfwNwLtUdeu6psId994G5I9uUjea9RntX/Z90M
	 L3Jy/vAMr7wHUilkoVXyjwKBU8/wv3V5Zg3elqJU6XBnAfE6YoFDjTw1+cjr7TrK+v
	 SqkNA95DzfbLfIbhd1VWe1bG0iQ/LLKTvbUzJEqDbPVUu/U+KAwNNvtXxMXNo8+BW9
	 5lV0ZLfkpl5HiVjTka9Euft6vZwzpMkjMMJq+y04Z4M+C+ofmIq+PPIbDf2yNBbF1g
	 yKBrMUc2FbbwkvpKC/F+Rk/5IMkmU2dVGhjLE9nxxJbe+c+8h6ORTU0pLRifH3+TiG
	 3TwbsfxKbbcgw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d02cc95096so445975b6e.0;
        Mon, 27 May 2024 03:37:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs4HCx3dZ0N5OGNt0xZ4TDxkh9E6Nm72eXoQApMAFJe3B8WDA0g9LoeJbTS/6Vz9KSLPEec7AXrW9t2Vnvcjl7feLvwFMDwh8OGuJxPd2YF1Zgi4IScvOB4FQ+pf3J7R4ccwvjzvdcMwuFvpA8CRngI7o0MYFKLadL9E1EnQ==
X-Gm-Message-State: AOJu0YyHUYbvZyTsmnmzKKxGt7o+h6NMh3MZcfvJmFWoTjnHh+K9ve6K
	NbwPzJf2YgJ/sI1D0o7/4e+nRLPX84ExNiCSJ7k6dLUVx9KlmIhG7jfPQ13wvzKoddhBj53ARpJ
	82FHdKn5oUp/XbIUwLyGmDD2Rvsc=
X-Google-Smtp-Source: AGHT+IF2FW+mgPtyJLUHni7RDf3OhqYbAMiUpR5ps+KWHwk0k4AocJmXcClKQue4FKMfLCG4jQFdnteBp+Lu/tVonkw=
X-Received: by 2002:a05:6870:55d1:b0:24c:b092:fd38 with SMTP id
 586e51a60fabf-24cb0930422mr9859752fac.1.1716806227238; Mon, 27 May 2024
 03:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171633159194.398195.10059732788629089925.stgit@dwillia2-xfh.jf.intel.com>
 <0da7f58a-309f-4e25-b2f8-3bd80902341c@amd.com>
In-Reply-To: <0da7f58a-309f-4e25-b2f8-3bd80902341c@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 May 2024 12:36:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ia9ut_hRPWsX3vAhABKwPn4eV8rgDjNjCppHpxE1hg4w@mail.gmail.com>
Message-ID: <CAJZ5v0ia9ut_hRPWsX3vAhABKwPn4eV8rgDjNjCppHpxE1hg4w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix einj_dev release leak
To: Ben Cheatham <benjamin.cheatham@amd.com>, Dan Williams <dan.j.williams@intel.com>
Cc: rafael.j.wysocki@intel.com, stable@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:40=E2=80=AFPM Ben Cheatham <benjamin.cheatham@amd=
.com> wrote:
>
> On 5/21/24 5:46 PM, Dan Williams wrote:
> > The platform driver conversion of EINJ mistakenly used
> > platform_device_del() to unwind platform_device_register_full() at
> > module exit. This leads to a small leak of one 'struct platform_device'
> > instance per module load/unload cycle. Switch to
> > platform_device_unregister() which performs both device_del() and final
> > put_device().
> >
>
> Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Applied as 6.10-rc material, thanks!

