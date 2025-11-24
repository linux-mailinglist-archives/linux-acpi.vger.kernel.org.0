Return-Path: <linux-acpi+bounces-19226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1642C8257A
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28870349DDA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B09032BF5B;
	Mon, 24 Nov 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToIXxtN7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7671332AAB7
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013905; cv=none; b=V7c1tHhWlibaWXkuqUEwAxpwgq/iElRisrFyssmx0BQRLI1iKx/m8v4dC7MZSUL6aRD+3/AcGYqZo41W60jRAHqV9zj9OqR38MRvC/8h4BKTa571MSPu3icX4KOGQKAZkMIFJFesloi/6uAvcEh5kZEKTwRCmlDSr4cMFaK1xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013905; c=relaxed/simple;
	bh=YPdtestLIasfV0KRLy9AY08HX0axh8xGitQGoNVyqwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJA/2vqA84FHKYjW1GrO27Wxl4w94oVzN7Nn+3nF+m/IOU1yLlGoKdoeRfjfrdeI7nh5IAFcE3u6hUdo6348JZMhp+VRD3jdGwQjNV+CLIB6OsjhhmoSKQDpMs/UPKBuBF9nt4escJbTh5ziX/dovRHxi8rUN6rIJHDftoD/5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToIXxtN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8D6C19425
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764013905;
	bh=YPdtestLIasfV0KRLy9AY08HX0axh8xGitQGoNVyqwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ToIXxtN7TGTKyhcWQCLg3HeiRp4+oMrExWo59cr/MOGeVbELfFfmWDB+Ei7h41fqm
	 3d8l9dMaKwhNXRW7ZF0gs0Vik2Ub5O5RqnifyICIwUYMhpfLaIuCPeYau0vqd1pMNX
	 56cIXNE1r462KVOh7btL0zkoAlCBCGSiGC6NhaARnEgK+HSBPqC1lAYpvsiJqNMu7J
	 Hxl3eeSWacPuwlfcn/9PqPlC2KVQ82WgyZq/Ug2wzCnYx3Iwyf/wS6SMmgVmVZtzhw
	 Ul5Gm+WrYoyhZyoHuSaGrNzI69qxCYx3geUPiPiiniKZXVA4WCRCLKPrLlp4h/gNg3
	 rD9vCOx6Oo+hw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e84d56c4b8so2829601fac.2
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 11:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5FLWfU9zWLxnM/CF8/pMhWLOJ8XZk6zonvcrkmlYIN6v/5w1Hf3kTvZNZS4z9zlyb2AhbhHqkFZPf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EIdrKNzWLV91wHjOCmAewBrCxSlK8D6HwUXR2KP7YVZQR8mu
	qJPl3/N9JtVVnRyuYexfRvNSdC+vpoVSB2cmiLSJEXLQxrmgF4J3QSFR4taqkvkUSArNDNrD8yY
	B8tYr9uyYfrEsyaTEVxIGHyI/suBXfCI=
X-Google-Smtp-Source: AGHT+IE16Q5ptvTo6zpyWU0I2G7xrkJ5diqaQdF0v+EjVaTTvdKcD0eao/xw1Xu2bSFTqcYSCsy0C/AuewTNpTTr1Kw=
X-Received: by 2002:a05:6808:448c:b0:43f:60b0:382 with SMTP id
 5614622812f47-4514e7f14ddmr164998b6e.40.1764013904234; Mon, 24 Nov 2025
 11:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120170001.251968-1-mrout@redhat.com>
In-Reply-To: <20251120170001.251968-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 20:51:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1Q7PcNLtchETbJ+1LhtMahCn75kzVCL7Dzb-bECJ39Q@mail.gmail.com>
X-Gm-Features: AWmQ_bl_c4Pn_vLzP5i-DISTb5bRLYcnHxS9LE8mJO63WQ_9Nqu8QnrjOH0DCuA
Message-ID: <CAJZ5v0i1Q7PcNLtchETbJ+1LhtMahCn75kzVCL7Dzb-bECJ39Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tools: pfrut: fix memory leak and resource leak in pfrut.c
To: Malaya Kumar Rout <mrout@redhat.com>
Cc: linux-kernel@vger.kernel.org, lyude@redhat.com, malayarout91@gmail.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Malaya Kumar Rout <mrout@redhat.com=
> wrote:
>
> Static analysis found an issue in pfrut.c
>
> cppcheck output before this patch:
> tools/power/acpi/tools/pfrut/pfrut.c:225:3: error: Resource leak: fd_upda=
te [resourceLeak]
> tools/power/acpi/tools/pfrut/pfrut.c:269:3: error: Resource leak: fd_upda=
te [resourceLeak]
> tools/power/acpi/tools/pfrut/pfrut.c:269:3: error: Resource leak: fd_upda=
te_log [resourceLeak]
> tools/power/acpi/tools/pfrut/pfrut.c:365:4: error: Memory leak: addr_map_=
capsule [memleak]
> tools/power/acpi/tools/pfrut/pfrut.c:424:4: error: Memory leak: log_buf [=
memleak]
>
> cppcheck output after this patch:
> No resource leaks found
>
> Fix by closing file descriptors and freeing allocated memory.
>
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tool=
s/pfrut/pfrut.c
> index 44a9ecbd91e8..4d9b0177c312 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -222,6 +222,7 @@ int main(int argc, char *argv[])
>         fd_update_log =3D open("/dev/acpi_pfr_telemetry0", O_RDWR);
>         if (fd_update_log < 0) {
>                 printf("PFRT device not supported - Quit...\n");
> +               close(fd_update);
>                 return 1;
>         }
>
> @@ -265,7 +266,8 @@ int main(int argc, char *argv[])
>                 printf("chunk2_size:%d\n", data_info.chunk2_size);
>                 printf("rollover_cnt:%d\n", data_info.rollover_cnt);
>                 printf("reset_cnt:%d\n", data_info.reset_cnt);
> -
> +               close(fd_update);
> +               close(fd_update_log);
>                 return 0;
>         }
>
> @@ -358,6 +360,7 @@ int main(int argc, char *argv[])
>
>                 if (ret =3D=3D -1) {
>                         perror("Failed to load capsule file");
> +                       munmap(addr_map_capsule, st.st_size);
>                         close(fd_capsule);
>                         close(fd_update);
>                         close(fd_update_log);
> @@ -420,7 +423,7 @@ int main(int argc, char *argv[])
>                 if (p_mmap =3D=3D MAP_FAILED) {
>                         perror("mmap error.");
>                         close(fd_update_log);
> -
> +                       free(log_buf);
>                         return 1;
>                 }
>
> --

Applied as 6.19 material, thanks!

