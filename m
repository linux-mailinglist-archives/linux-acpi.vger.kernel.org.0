Return-Path: <linux-acpi+bounces-16019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16788B3450C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF05485878
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6912F9C2A;
	Mon, 25 Aug 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ3B3sW1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B37230BD9;
	Mon, 25 Aug 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134044; cv=none; b=t7+lkLT/uH2G28IP02TTwF3dGMhAPmNujMBSJundPVDKdc5/sCUiWdxvWIfxHUmOi0ncY8pPn0o0aqTBGObhtnnH0aeQSYsDdluRbL4KY9NUUdRatMMBqYKwTBqHN9uaix9Da6oZlzyYlnUgXojJEbNBU575zornYxHNVdOnY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134044; c=relaxed/simple;
	bh=Ugep9HJbeJfe8M4p8+iQD78EvwPborb+MpXZjz1LLv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0b7Mhg9wDVOi/VZpHiWLvxuZk3ri78vGuXxh1GkBmkn/9WLr3Um7jRe7m/FP6UvZDmr+s9+2Zw31tfO7EAYb4Kusg0PSSDpwo3NpYX/xv7MMWlpfcmA9wutZw8ppzYupL63g8n8coBbXiRW84dvURe81BZE2QkdJ/kJWTR5Nbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ3B3sW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F6C4CEED;
	Mon, 25 Aug 2025 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134044;
	bh=Ugep9HJbeJfe8M4p8+iQD78EvwPborb+MpXZjz1LLv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJ3B3sW1HPRV/CTE9MtLN1EOuCSt7b45AHK1+O05ynTUpvw3tfOKETm0augsqAedL
	 M908nFI2nPV5M9LiGteC6X9Pzi32TpthSl0GovzZUpKzh61MUc2EYi43IYswLCUEKn
	 oIXDqRzO7+yBb+TT8rS50oulKoQnCdeQao+f5HgUC4gk8na/Zo9lSo5DMS4yWAGu3E
	 PiMXU/7aw2zp0FIyIoc1P40BsqbBaPK/1mm1hNdOs0NZho2EulbTMY9ZbEDcb0Vo9q
	 7jLSDnGl6ufuX7O/8uSppxhP6on6Pp1YQapYuyF9Ho8wcg2M7jFhFONqaGXCHpc/FR
	 vOz7bGG1PBEow==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74526ca7a46so246511a34.2;
        Mon, 25 Aug 2025 08:00:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7l5eyvsdcXKF1eRPmmLUHh6Z2PaXeyoXORMNpsghynL5Er3LtDHGtjwIXe/CFAgcLYqPnaKsFzZCgwXK8@vger.kernel.org, AJvYcCUoLZF2jpPpN4O2KVBMQCtFYv53CKojDsAApUXKh3A+oktLoNQma8hE2Krb2NA7W4OEwxPt/R02ECA2@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvJq4jLCA1GLfND3CGk5PyW024dvalC6IXjthr7OhcbCMpIYZ
	fKgBdS0ajGsUxf7p98rDW7L6UEA32LifuWfyOb9GpcllE1FaPIK6/A9RWApgNieA3Lgse27a5Cw
	i8sxiwbCVFZluWqQLnMfVNfRj5npFeYU=
X-Google-Smtp-Source: AGHT+IEIVMcl7vcY7/0g28+jH/GnesR/QNks6r5gFelznLt35hSp/7TVbhkQ9Oj6ak2sa1zxL8Lb4hUwuDTJMlZOWnA=
X-Received: by 2002:a05:6830:6993:b0:741:c135:6afe with SMTP id
 46e09a7af769-74500900005mr6914482a34.5.1756134043404; Mon, 25 Aug 2025
 08:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-acpi_fix-v1-1-a05ebfe1b8ac@uniontech.com>
In-Reply-To: <20250815-acpi_fix-v1-1-a05ebfe1b8ac@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 17:00:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaAgpGhtH27j0hRDF7-S9F7uHZ4GZkmbfVLQOEN+6tbg@mail.gmail.com>
X-Gm-Features: Ac12FXy9-BKrAqjrnflwZ9xHHH9i3P1dUbJZUPC6joJq9vDyUifwXwn9qEFGP-A
Message-ID: <CAJZ5v0iaAgpGhtH27j0hRDF7-S9F7uHZ4GZkmbfVLQOEN+6tbg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: add more parameter validation for acpi_walk_namespace()
To: cryolitia@uniontech.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com, 
	guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 10:56=E2=80=AFAM Cryolitia PukNgae via B4 Relay
<devnull+cryolitia.uniontech.com@kernel.org> wrote:
>
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>
> On the Honor FMB-P-PCB laptop, an incorrect ACPI table causes
> sdw_intel_acpi_scan to pass a NULL pointer as start_object to
> acpi_walk_namespace() when calling it, which eventually causes the
> kernel to report a NULL pointer dereference[1].
>
> 1. https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7
>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Please submit ACPICA changes to the upstream ACPICA project on GitHub
as pull requests.  Once they have been merged upstream, you can submit
a Linux patch based on the upstream one with a pointer to the
corresponding upstream commit.

Thanks!

> ---
>  drivers/acpi/acpica/nsxfeval.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeva=
l.c
> index f9d059647cc52e94ce013af3382addba338820e8..c1f318ea7d5fcd846dc158b15=
5286a6f5bba4cff 100644
> --- a/drivers/acpi/acpica/nsxfeval.c
> +++ b/drivers/acpi/acpica/nsxfeval.c
> @@ -564,7 +564,7 @@ acpi_walk_namespace(acpi_object_type type,
>
>         /* Parameter validation */
>
> -       if ((type > ACPI_TYPE_LOCAL_MAX) ||
> +       if ((type > ACPI_TYPE_LOCAL_MAX) || (start_object =3D=3D NULL) ||
>             (!max_depth) || (!descending_callback && !ascending_callback)=
) {
>                 return_ACPI_STATUS(AE_BAD_PARAMETER);
>         }
>
> ---
> base-commit: 24ea63ea387714634813359e2c8e0e6c36952f73
> change-id: 20250815-acpi_fix-3724e6c4da02
>
> Best regards,
> --
> Cryolitia PukNgae <cryolitia@uniontech.com>
>
>

