Return-Path: <linux-acpi+bounces-6565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89238912211
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95E51C236C2
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631CA173346;
	Fri, 21 Jun 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC4Yxdrq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B029173338;
	Fri, 21 Jun 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964979; cv=none; b=Y/DeucfKf+ypSBsEOZCRLHctIzd314nP3dkvM1xSvWHmqvUIES+0beMVWAr0wIDJbQCBP9sJK6KvRgFi4Akgm/8G/GdJIO5YL8ClARu+0RtBFz/ABqzqTHhvNFtq1Zf+HRzCUxyD3T+M8G2j4a74DFZ2P0kb12//VxeralGJmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964979; c=relaxed/simple;
	bh=A0J53uMMX8HJS2MDtBNVrL68qeXtbtsy57wU79YR4bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6JKoCH17CaScdntSFFNsOHiQ6s1QH6MaoojaxxEOQRd4EcMDzF4MzVyusfzCg4nqIaf1x9O/5BNKqHHkjrcbjbGG9mBIyWK/IF8cCjEPbuB67WSJvia/S2+trOVL28+XKpJ7/g2p/JVsO7F6zcXlNV34GuPgq/lRFSUuHBJXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC4Yxdrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F0C4AF08;
	Fri, 21 Jun 2024 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718964979;
	bh=A0J53uMMX8HJS2MDtBNVrL68qeXtbtsy57wU79YR4bY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pC4Yxdrq3iWtH4DzBLsuwci0qV+sQsmJfmft3fsqVrz0RPgqy4zh9SritXzjWxymZ
	 E4VjxxWNSo+cDZoUWBh9r9OVRzdasVIIN65pJr3A6EA9LsffJelF7U5luWWl8qvCwN
	 c7bZ4i9T0/LiKG1TJyi3C6yHqASAiOp98EwlCfPU/KUdZYiiXdLQjtFd/zZlVZkbgN
	 dHYR4c5xawQ1HY1f6imiKJUXs56QpIaXK1MwHIjN3M1rw7HeBhYgFfq85gqxPT9mYF
	 3PCwrPr9aDBPZIkuuXXdEb6wjEzoMBScFNSRuItYjC0DA9G7VzNU+oGEpLCFzD5uWw
	 OqKS+waw+TORg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25cc44857a1so71568fac.3;
        Fri, 21 Jun 2024 03:16:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6iA1WPGCQr7T+aHcY5KVF7wAwNsn+MuwjI0iKjYjVQ1Km6tjgI09oqlqN92fQYWUtBvY6qKdaXFKpQ0Tqf7K5prSvKWH7LSUlzsw4py1MeiZnhptpvwVfut/TxdjuK8ZJRlGctHH9wQ==
X-Gm-Message-State: AOJu0YwOEMPVMLx1fDWXHQY3JA2ygKcJ9fey2spJWp7oX0kmBUjl3fZp
	jeSI3lvbs+/w2+gaR/ME+l5+fWz8C/nE5d35J2zZayhCTjTxRZCO96htyzUiDgUZfLftFxjrrQW
	S4YTO0/wWESMKyEvUATpMT7D2cps=
X-Google-Smtp-Source: AGHT+IH96NlTGboWpZ1N8t19sfFHYnm26QATqImDEh465B33eF7aJh7HyDzkRvLVqlDInBVxkFj2sZ1BUawrXWlI+p8=
X-Received: by 2002:a05:6870:a2cc:b0:254:affe:5a08 with SMTP id
 586e51a60fabf-25c94983780mr8402996fac.2.1718964978445; Fri, 21 Jun 2024
 03:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606115541.2069-1-ptesarik@suse.com> <20240621104848.3f14d60e@mordecai.tesarici.cz>
In-Reply-To: <20240621104848.3f14d60e@mordecai.tesarici.cz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 12:16:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBR1qGgSq3+sYU_7ChphHuL_R7E1-LBjXE3FdWUPkWpg@mail.gmail.com>
Message-ID: <CAJZ5v0hBR1qGgSq3+sYU_7ChphHuL_R7E1-LBjXE3FdWUPkWpg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: add sysfs entry for guaranteed performance
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:49=E2=80=AFAM Petr Tesarik <petr.tesarik@suse.co=
m> wrote:
>
> On Thu,  6 Jun 2024 13:55:41 +0200
> Petr Tesarik <ptesarik@suse.com> wrote:
>
> > Expose the CPPC guaranteed performance as reported by the platform thro=
ugh
> > GuaranteedPerformanceRegister.
> >
> > The current value is already read in cppc_get_perf_caps() and stored in
> > struct cppc_perf_caps (to be used by the intel_pstate driver), so only =
the
> > attribute itself needs to be defined.
>
> Are there any objections to exposing this CPPC register through sysfs?
> I mean, if everybody is OK with it, the patch could be acked and queued
> for 6.11, right?

It actually has been queued already, sorry for the missing notice.

It's been in linux-next for some time even.

