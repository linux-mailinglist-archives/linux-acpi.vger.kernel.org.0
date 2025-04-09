Return-Path: <linux-acpi+bounces-12903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F382EA826A2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E20419E7545
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B62459D6;
	Wed,  9 Apr 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak0buA3x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCC12CDAE;
	Wed,  9 Apr 2025 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206412; cv=none; b=ICcRT1CEJGIE8aF+9mox0yV2L8fZmk+M4seWVxS1BNbxy7LXMcggteWAXVPhhrQ7Y/DqCHqX43PDtkz2awGo4LjNLIUpMcv8eyizrQPnGT/PSNjhSawd2V2vILl1+w5BAxZPnjDfqp/RtO6KdG3wLFg6gqQKlbgVu4aws8a25rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206412; c=relaxed/simple;
	bh=kq4GwUL2Q55BebK/rr60Z9iWtTVvFbF1MiZJc46jdZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALTGvhhoX6gMZKjAn3Hut9R3iJUAYs+nyiIl/7pc28/Lq204U8ZMK64hql29rGw4a/WoXYWuGe9rWLU/Q8luHm+NBP2Oi4jeTD0YF1ZRsH88/hl8uU5573XWLlMVnehk9+SzJ13qZU9U21lanAGc+mnLB25ZCGmTLnOmbXKAvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak0buA3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8777DC4CEE3;
	Wed,  9 Apr 2025 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744206411;
	bh=kq4GwUL2Q55BebK/rr60Z9iWtTVvFbF1MiZJc46jdZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ak0buA3xkzS8nsSRb64mzzucQ+1j7sXeYIR1wZ68Ob2H6GJ9RGQ1/e1FeuCIm0VA0
	 17w+OrYh8vJijainH7yeknv72BpxWtpar7CpxJt0FFD/gM2P2S4HdexGtViluo7SjW
	 C2yl2A+Qo1jqMZUG4CrkNvZghU6ZUPivXy1DaELgm5vzWJE51HGeBxrPBoI0TOU1Lc
	 TB95pfbEkS18vGCKs2H8cUOrG0UdMLtYXtggPDklTA699AwjRjM01Sy6UulRnol7BE
	 qanial4pgygTDJUVrqiWQ8UJOKbKe1sHIicx8tbEot4x+kSqOhut6movGLTlS7A6Kg
	 H7evgP9KUbroA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b8e2606a58so3651663fac.0;
        Wed, 09 Apr 2025 06:46:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwPrSSE6w5unOvCYManNsR4GMr3SutfwjK2pxT74tEjzBQsC7dsktLpt2zqr3JCq6m3FdkjlZPsSn+@vger.kernel.org, AJvYcCXhrSmf7GCKw7hqVRH56Rl9jAL7pLdtMKZXczeM8EQt93GQar1XByF3dXOR7SOv7sqHg1CFVdeUYo/1due4@vger.kernel.org
X-Gm-Message-State: AOJu0YwuP8dEz5pW9wD0JhRTsg9pD8ENhPvfA8jVVQi3ZmW3T9UyeYS3
	ibGOm0WkMHSkqR+Wu8iHOGMQJLcQaU+Uph/dZTcukjEeDoGxVvC7A7w47zaJm0ccLkaIxKArWLj
	9iXJnFCibRf5R79cx8UycLt6Xe4U=
X-Google-Smtp-Source: AGHT+IEJwKF5kKdWLH85lzefVtHBF4UnufhJrxK0x76HKl6Q/kiHuE6aj13tm8o/0T/ArrKKjSNCTLJ1Pjw50gqjSeU=
X-Received: by 2002:a05:6871:331f:b0:2bc:76f2:44a8 with SMTP id
 586e51a60fabf-2d08dd9429fmr1699199fac.15.1744206410863; Wed, 09 Apr 2025
 06:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401184312.599962-1-d-tatianin@yandex-team.ru>
In-Reply-To: <20250401184312.599962-1-d-tatianin@yandex-team.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 15:46:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_5mrCKBc+WMWviZa1r8x17rDX8DzCyMyQf=gwrTa0eg@mail.gmail.com>
X-Gm-Features: ATxdqUEqiaZRzw1Av1pBCHPMNdPQnsKkueM8V1L6D-xNLbkSFZO5UsCOR7upNM0
Message-ID: <CAJZ5v0i_5mrCKBc+WMWviZa1r8x17rDX8DzCyMyQf=gwrTa0eg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: exserial: don't forget to handle FFixedHW
 opregions for reading
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:46=E2=80=AFPM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> The initial commit that introduced support for FFixedHW operation
> regions did add a special case in the AcpiExReadSerialBus If, but
> forgot to actually handle it inside the switch, so add the missing case
> to prevent reads from failing with AE_AML_INVALID_SPACE_ID.
>
> Link: https://github.com/acpica/acpica/pull/998
> Fixes: ee64b827a9a ("ACPICA: Add support for FFH Opregion special context=
 data")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  drivers/acpi/acpica/exserial.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exseria=
l.c
> index 5241f4c01c76..89a4ac447a2b 100644
> --- a/drivers/acpi/acpica/exserial.c
> +++ b/drivers/acpi/acpica/exserial.c
> @@ -201,6 +201,12 @@ acpi_ex_read_serial_bus(union acpi_operand_object *o=
bj_desc,
>                 function =3D ACPI_READ;
>                 break;
>
> +       case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +
> +               buffer_length =3D ACPI_FFH_INPUT_BUFFER_SIZE;
> +               function =3D ACPI_READ;
> +               break;
> +
>         default:
>                 return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
>         }
> --

Applied as 6.16 material, thanks!

