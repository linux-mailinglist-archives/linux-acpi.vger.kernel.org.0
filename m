Return-Path: <linux-acpi+bounces-14592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FA9AE85CE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4883BF161
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A01264634;
	Wed, 25 Jun 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lngmZW6d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAB1F460B;
	Wed, 25 Jun 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860503; cv=none; b=Hq3YXDqorE0Xk8UYOWRUQxruiie68MG9dJr/wljvmxKzlB1ECvngmqU8XoJ1kgwDZ8nhjcWPXBU1I+0bS0BQSIJwROcOazbKAyNM8K0zJ+OQzULMKgA5IiHegUqGTh0+2bmdHPCVzT1GDdIDuo2jL2v4Sg/0P/60So6czwh1HrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860503; c=relaxed/simple;
	bh=4vIZXsuKUOK8a+9KYnOCvceaIEpUDoSD0Xk7uwoqMOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMmspn8iRhgMs/D+m26rsp81f1m6HmkZ6+ZgimeWuUf2+mCyhGltFWgjdhdvuEffRk0brcK6BhiFl4EUgyuXUi4IWv7RR3b3dgfGLjdb6zKegWJEn7nB+W9bdaBfr0yDTpOaD6QI7AMB1hJkVwcMVRhoKvCriTAlxlVq6gVCh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lngmZW6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C74C4CEEF;
	Wed, 25 Jun 2025 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860503;
	bh=4vIZXsuKUOK8a+9KYnOCvceaIEpUDoSD0Xk7uwoqMOM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lngmZW6d0OpP8fT7KC63MqY2H9hdncczxcomCYo6wSWtTNWpuz8+AIsrUiFz+fOPJ
	 8fbN8gNOBbhO/8Fao/0x2HGRzaMfeTFc8hxnKzGVN5RALl9H+jaMWsBV8MiV3z7KSI
	 CjiRa2BBx4DQ0UYeofft+dqdiCJ3tqULlAby6vr2ZVcj5EJVAkWpk7LGFzE+8H5Lie
	 oBhWKD5bmtZ2xSrNSrdDKdQoGrH+vcfkBaZae0wG8j//aLCN4xXshLwbC2Qe9ueGzg
	 JE5xEM/59eYm04/v5ydoUlBfZWN9oAM14Ku5vFMLNmkna22aCWJZT3+A4W0aEAxnVM
	 TDag+MrLCvGjw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so3004549a12.3;
        Wed, 25 Jun 2025 07:08:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/Mvq/yV2YJyuxRCir2W7Q066nimiCuzc7Sk8+y5Xd/F1omMi0YMe+7BjkslWerO/r32z+2uMR335Sh94I@vger.kernel.org, AJvYcCUKmvz/1oM6RqXKdajwCTp3xC6aOO2H/8shdoepSohfiFocDxCNhvRrIZ/OCVRbz75Fe1zVTNVnWeer@vger.kernel.org, AJvYcCXI1vRxNC330qJuJgel7/RTx6PkLQfzPUIPo8TsPD6lQMT5irCGzpAHAC8Cb8xfEaGvodKgOdqPjNOlaVJo9Xo=@vger.kernel.org, AJvYcCXgYtaHC58mtnJMfYlSlbHh/AZTCPe6bxl6lhV4F72bhV+Xtau8PFxc0XAdL7GgNXGGl+s0//Zmv2F3Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLWD6lnYsiYD8RrKXtjNDKcELGnKw3AH1iXI4bjnHpcfudbT2
	fZJG5AXADedH2PwbYCFZwWYD4oRdWcWk7ejMnDcBROukd3rtmB4ORHjHt+8+iBM390qmpU7IkKb
	NSOK0afLSmgVCbJgli8zdmuiNspyhsw==
X-Google-Smtp-Source: AGHT+IGRQMMmj3unS5ciqd3uH6EUFNd8IVgWwlI/rRMie8w0Ra7lYzi6iW8icoIkLFesEo0jH7PHkSh2vWz7wpa1Ab8=
X-Received: by 2002:a17:907:2da9:b0:add:f62e:a300 with SMTP id
 a640c23a62f3a-ae0bebe8ff6mr342351766b.2.1750860501819; Wed, 25 Jun 2025
 07:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com> <20250620151504.278766-1-igor.korotin.linux@gmail.com>
In-Reply-To: <20250620151504.278766-1-igor.korotin.linux@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 25 Jun 2025 09:08:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZ2bPuBZ=gskWGuk6J-g8iEKUBSJzNPp1R_0h=-gDLjw@mail.gmail.com>
X-Gm-Features: Ac12FXxJ0lIPGJmUoAyYij_5Tc5EGrA9gwnPxeT8GjAH4rphivqHLogw6AizxSc
Message-ID: <CAL_JsqJZ2bPuBZ=gskWGuk6J-g8iEKUBSJzNPp1R_0h=-gDLjw@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] rust: device: implement FwNode::is_of_node()
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Alex Hung <alex.hung@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Remo Senekowitsch <remo@buenzli.dev>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Len Brown <lenb@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:17=E2=80=AFAM Igor Korotin
<igor.korotin.linux@gmail.com> wrote:
>
> From: Danilo Krummrich <dakr@kernel.org>
>
> Implement FwNode::is_of_node() in order to check whether a FwNode
> instance is embedded in a struct device_node.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  MAINTAINERS                    | 1 +
>  rust/helpers/helpers.c         | 1 +
>  rust/helpers/of.c              | 8 ++++++++
>  rust/kernel/device/property.rs | 7 +++++++
>  4 files changed, 17 insertions(+)
>  create mode 100644 rust/helpers/of.c

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

