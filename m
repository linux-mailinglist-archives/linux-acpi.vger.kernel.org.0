Return-Path: <linux-acpi+bounces-19850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F1CDE03E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E3A30000B8
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045927FD71;
	Thu, 25 Dec 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Yb83yk2h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056C205E25;
	Thu, 25 Dec 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766685995; cv=none; b=Hw2CMeWmCYXvaQSBRs4l5TFLwKjKAys6bLHSR1+C6wx7xVJlMcwOYersLLARuyZMNlD+Pv9mF6SgedtgsdZmmSV0wSnJqbioh19Doobk9pUTiF89Wt6RE9GOmt53AWF+IEa3ZVuQbn52z3OEq9GGXEGwGpr83eErG8qQNJbjwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766685995; c=relaxed/simple;
	bh=afgxfFzCOjJ4KJ61mDePDnwZ6Jo5rRIHkAubotxaRXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ey/No9Zp1lJsT2Lbk+6xHtgU4Q5PO5cKA53nXYzzAU57U6/Q8HGvWnWhSzWTd1yca7sqMtvv5pR4voiLrMmsLbvWr2LSmt1okz5neghMgTUBJmfjjEK03BaGyH6C0smkK/D+TGtdJxc+G5MCzLBSD/Ia2C7D8c+tpR2aRIDcjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Yb83yk2h; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766685968; x=1767290768; i=w_armin@gmx.de;
	bh=LWkvmuks2iL4VNtGU/9f9PqZ0TyAw3XjQURptt0Izm0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yb83yk2h1CPjjMePVNXhP4xg8N3wYbS/ahCyxrEvi1Qvrnaopc6qG2PNDaRBBPkl
	 PD6o2biIfvZG5lYMGywcI8KNxP7SQv3nuedQEPpswdC7JYmzgUhOzyQFZj/atw5AL
	 4N8cNJNQ+YW9Cc4E8nsoAwIaMANj5bvVHurdPaUhxazAQdwHyi+lP0i0p41CqpbZh
	 SEDde36fWNq6g7kV5ga9KRpwtfocQwpaLo+1oiJoth6UBwtbL1LwBeNVoKMB49V/c
	 5wAY0Ob2Aeac5etmLqeluxCetJ3l3GHJRropjTgLuZBaz6FY14n964xvzuHkFcCLS
	 qYKI4eDdVUxhA+4R/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.142.23]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1w3NDK2xKz-018K5B; Thu, 25
 Dec 2025 19:06:08 +0100
Message-ID: <854b4448-3ff1-4fb4-b58f-21136f5ec3e4@gmx.de>
Date: Thu, 25 Dec 2025 19:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] rust: introduce WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>,
 "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WCi1f5Wt2fGhnA1a+8p+wlJl6JJB8MiOBMAOxNh4eJPrP1WKQdy
 ItQ4MNHcuJ4xsIuJrGYjXhe1pHBRsaVMiQWC3poC7uqMWoIcWx9vIEwp6svvigOmc3vBJ7E
 2vo9l/p8wN3S69Nl0NdGdU7yATPtl1wquyRwaf+xCXVcwt/feAg/V/tuLVraq3NWTmbNXiZ
 aE2gexxTTAhLTBGmrFxrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WRCCqZVVn3s=;K1GDwaWO+bJ/41zFI+fnMZB7OeT
 z2qkev0b2zjZL4ObzcquM/RT8s9WahIxd0H8dcG6o3gIl6l/LEVzeZLsn037FUOJrlzoQyBNz
 rDUjk8J5Gkix9W+uaN0Wkb/cc0B0ZUpBNR4oUI/7k6ZB/D9d0jUIA1PTFNi58HQYlS8cU05wy
 wy25UhwwkFr+cQCc54N/HUPs0f9QVjyXN1FuglUfaozbJwjlUG3GZP7GSsaM2PWSPoW4jsEvq
 Kthz82OuvZRRoDLfpCCYr6b5YlXuQ567byQH0WH3d7usyb3HbuImI10nZnYvxEsyBpQ3uYp07
 N/6m09wIdVIKue/7HbybxsZPiQSAbkYZ3/0c8BXr2rClik+V1Qc9luVSnwYFw/ZZOcNXJufHU
 12WDovZ+8jLzaxm0rfrf9QgVUUxPL62K5ucswG00L+PJKBNOhkVm99yujquZcnKXwiL+tIxlb
 7aa2zH0X8hyBR5bCTit/mm1466CEUPHruw8YcgNLVvLXFBnvTXOq5dzmmH1c2DtBZL3PJE5kA
 YkvzEFIBJuSYFlTegaAIrPiCo6G/gTPBTwG0DvrW7TS9e8L8jJpRnHAAaacmwgNqSOqzW72k2
 /FbKkz76R8iOQlTehsfg0skhqMAxpTBMqSBCO2lgxxaxkPCd6rWoinIFOjPuTy9+593ckpLw+
 XTVUFmIOIOXGhN03+gNBB9ry1ecwG8W7cD7w0P7vWxs/UHQsQ0jwSLzL1wjseDaqTI/o4VSjj
 Jp6+2M5woM+YZSRxQznBCdvXVtT5+Gw+zKntjV6iKSmo53Yj0N/Thp02m+cbrsx0j5THwoglW
 p0pbAcB3bXXt1yd9erZMZngJo3v52CwDO0LUbmGdvADVfdJgm6+AZoVc7V1RlJUg69u5lPA9M
 SFaruQrSo940uiZrnmc+sFtMI7mKO4bIk7bq9/SxIrBj0wuZvFtGQZOS5pGwK6+7+dT7qCbDG
 U1tLkcZwZxSb31z0i2SvawvcrJb45uvMNJexqid32VyL/TNmpMu88ig04YTEG1xdWfIPrKNcz
 YeXSt0Ot36ZBlcleHkWZ46DeFbqucE5IovAUm0376PrDXDSR51ox+53LCbPeTOPzC7RB9oVzN
 4rEyS2ZuLeqlErsD/5YE6f9srvn13Zl4SIEXY1SumI2U44OIXeTuIZkJYp5aIJeVVEKUNvnDb
 Cvfirh/xe9+I9BUKyyHEY4JdVAGUbTG2OJLmZRMq057X0cKWnsZug8+rh9eYbehcmmqWGqNY3
 M3K117JpTkR6xaRRh43m/GgYuoowOkO3z0cYeUdn4wuwG/M4bp8Dtj56eL+SG+wkpeIke9bUu
 m/pI2dtqh/2HPTpLvp8Z1xOYUmdSENcS03K29Kx7rxZ8aCGzRGjGOlkWrxkaQs+Mm9SjGpBPw
 flim+SCIzrzi8HpHCAAk7fb65AAjgq09AKLio1bd7mF4/KRuJsVmaXWV0oVqrr0jr80IuokGo
 oC5ox45iOLpTsRfd+yjeNZLj+1mlRUqcjsy2EyYIVhFiV1NTNwwq+4CosNQfKH8zT7cjV0hc4
 EQrOky876lA9PJRhoj91efZFP5qpAyPD9gvABQptEl2VOearvX9xMtE49BeumtZpB6kUcYqUv
 y2VrgyG+Tnt3DKDPpAngbreHH4r7LQi/OsOAiH6zuLUJX9WPDtBUTY8747hGO2p+dMM+sUSw3
 Oke/M51AcFwLVdnezbKhWKDZvWIuWtzQXsFb3O9PvKfWfU/E4ucs0O8fQw/3RMMXCpaTlY4Ym
 +FKjmaO4aBD7L8PITpdys3qJy0oGKSZjeZZg8zV7lO+FseFsHcdNXOOW5DLVkufHaA1/ANnN+
 x07rn76zrzD2dpmzHWWsfQFlcseLt1wjbX9ukSwbfaRw63A2nX0Gm/RCAm6Wir9jQQbneWvGz
 3crRxDjGeOFOvcn+secESxFuh/B/k4Lu0drxgBCkZxKbC4/7fdDQHMWkFRizfhJ/QchhqenBC
 MTNxZSuKu+uYgrh+3NkWxmvB4lx1LIKcj5XXUpKK5tX8w9o8cJYh7YWZee5lX+GMPBtAdU9BN
 qvM0sNmHSRuL38KshIroPHZNQlAV9QgTfBFtswAmi61Y2jYfG20u2nmFWTjfdmUVwA9iJE4Ci
 K9LjGBvOIDL5xq6hsVNXkxQjXIeiOxATOw5EYw2aa56BFiEH7AQXh1oUBlNkSR35c35EXJpnU
 CNh8IZAQTF+AxqWbmp8xklq2wnECmFfM5qtCuguZfWo4h19h4x4UiJYZJrWWEUzAO2I6YzePe
 hXXhD2kyA7d77DJAp4hmmB6yvNsKLhKqkGdqiYO0WDkkgvyh4vIZ3UyRYSKR0a7riTUwlI/Vt
 liYotjK5DZZb5d29zKRXmiHy0YaBrUNbpwkyY1HOLOO/IVZTb0rJv0Qve+tC1K7n4292PDjmx
 hsrvAXDygiw/+uR/jNzneu6UtZ83VG3Ed2OzuHQ6ZN5YKr0KuzIo6GF1Wo3XoCPu93Sq9Ot55
 6JWGoe+RzpKSV56DkwG/02peXsTOG35Agt21LcBbi9UYBl8XuWKMmVmj423bYs9vf3G5B4VP6
 raHdb1DQoVU+OZFVtYCLDLdTbUzrOTZVFyfnCiPxbgJCfP6mN8Y9OcoyYeKHzSJAwIGL6pe6i
 stRzKMFj1uRXb9ePdLARUqnkL9N7e9+7e2wNa03WBHoZm6AU3xySiDVeQyDTw0RLiyBQUbtHM
 hZ2M1ct1BozqAZQyq0hqTi9nfIGinZaI/YPay+w0IczOJNzgzAuLpxzXnrn4jD3MG+SpM6WOp
 8TgJUltyPcRKWxVIcaApfkdteHAh3b0Ojf7uDSuVZEIOpR2oE69G175UE4jLwrmFWVXvDdZxX
 Ykm1STrE9qAslnNdU2YXAWSffjKpk2XG/mPcmvEiQ36CHskAmE+in1K/kwQ1gg4tIJwnIE9XC
 9mtvdxShgU/xKFdPLjz68Nvujm6p1/2iFyKnY1KHw9I73C4Y2602utmankRae8+ek8VhxUTas
 5y8D7J5SgWzgs3WIGC3razsRZfrbCrI7a3BMvItmAcYxgTUns5/DL8yN36sL6GOoo1XBi2e90
 DyHZZM8KHUavef6fjNX9NdaCGr7nM8XisGO7A1vctEmEVMAWj0rt97/Enmim5GPDZq0ktQovk
 hT3zSa41Kq8Mk+Z/IciwgEbZ3OlUCUZS3ShXhRWBR4AzjHhZhN6vzF5amQQs573I9hg1Bi1u+
 VCR+HeTP+eHcwDpaourmeGk88JgjMHcJcwsNTfwm9IcN3wwY1rlzAE3/uBVHqj8HWIxEKsGMT
 +wxg5PmamABjlSLFMLJTBqI3M9QbwRGVaVSPFJurz9kahvS6MeDJ7qyifsiKNJi/pl1Al9cnq
 8x8SHnRa432EnSmpzsug7MR1K52wPifLb9H7ypg7ct3MGHYzABvkoNxULlrDWV/Psx26jgLiS
 pii0YntlA3Juu21hxyGQD42ZxCh30ihue+OmWH5vgDGv/PzY7ovZELLYHBMZdvAa4DdABUQYN
 PBcIQuqfCyjoSUe+Ru8Remz5bg1U0aEtcxaueAMAm4+6gt9ZANZb2lLvB4nNoduSvj9qIVArk
 l6SmioXuWc8O+3pPcPmhvuFGF88uiiZ1te0z5F5vJ6B0H0H3bW+clLIIwCkFWp4DICDwj6wOF
 RYuQcd1uSdB/jyY2C3OPzotl/qNRFHg7D/aPK9j5JsRRXxZ1xlB6jZ+1eMlY06axd9uqZ9zGD
 0z3x7GQc+mRUAJXCvzkdRTLg8+2LxbXscCO1qnEWexMZ1WnzF8ctdRXt7k0Sc1kI05+mNXz+I
 Rgl7BhPQXiOR80pCq5kcJADq0SiuroRXIDUDPyrYKgM7JJrrYkbZosaUWkrvnIxhce+b0MD8o
 HcW6kPLArQaO1stnTQrnTZCL+4jSeM8cOvq9TAGE+dnWvWTzsXJh9QXg6yCyZPn1B2CmQbvpS
 Z0gbOti/S3naiH2a8cXgjLx4SF2DIeTC/VLqDA1lu4XhiVmZsKenQeV/uuCd5gcNMYhk1ENEC
 Gq+mo0uKfq0fcJq9mViHekMizwoanRFTDaKHuzlHalTYPHFg+2JobIF1ezdCcBdQ22jRrPE69
 /tzJCOZwIwzYhH67e6eg+WFR/dv4N6ykFYHw1FmIgKeUqj0JDAUG4OdLHzn1B4bWGqFy27JmJ
 1w9U2zwZnSVBZmNzHdUtu9ASyc6YpzhpNQP7N3zYXoFrfroSsxna81Yi4UT7bR+Y7xQy/7wUp
 eXNRX+MG/al8GCHNrJZ/0LxE8LT7b/a4V9FA3zlRyGQFufO4yK290mUnP/vIPRkdlpRF5AEwK
 79oGeASC1mpFglmT6NI53p8/dr6zYtyuIa5JWr8VryMJxUH/xbz59u+HGHeNdmbw0EhUJHY2u
 eThtNO0bGHdca8HZCi3IcXi0028L1xil+E6bBA0grGtY4roDi2ksbvVlhTMDNrv3YI1vr8lFS
 o3EMzGN5HimLwjKGzEefiHpw+wAzy/4cxXEvIDk5xXtIRIRDrE4jqqe1KKsbDg1NVSsq1ygEH
 dWWcIfaT/ZJ0wf4afI63lqS1nZmyy8Y3LSSVjgcr3e+LiQVX6yWW8OCoYQ2Zz2z81zdWtW52+
 AT3WSMJYXpQsWO2s9QWOiDiGV5606IwGO5VPFEKt+ZSrUNPYZQbwLyIwGn8IACc5YxXvJ1VUq
 3uW2b0E8snx95MsIgjQPIrbxpqNzIH9mzDjnWvo8vmknhsYABLqg4fljAGtoGptMaXp/uU3PU
 /r2d0Ki2ioxyj06Q/fRTfvFdagkNET4RJ1RTRwRFfORWTOJwt6azIPXmzl2QtBs80ao4h7p9t
 8bKYPWtjXy4pDDKcoPqaPs0lSZchahm2oyYUmsZgsEVfqcJCdOOzi1Q+h8INMD7ivflFS4dLg
 TzpY9/knwjqCQn404yqWhjlA7/AoKnh0lNGnz+BnIYeXkmmMYZ9RJpk8EqEBWaPlUOIks5yFa
 m9xXIwfGkthWsHqHW2FXvXKfTREs5D48EtoJhJ5i/5EHkRgKMWycRZy1EDqbNC0Vo5F08jqke
 u9/ByRzaXF/TZj3jRMSoHL8vxY+fTOBUfshSZkLXjOboqZLppaF4P2KEivnQ1WUJxj5yZuDfi
 s4NdGVmfHZOJ0g8cRZOnAtRsBCtlEcC0m8YifMXPc+SecyD9l3G6EiEU1u39fELH0BKxncl7N
 gvXwfaNo4LqMxLtoyj3XshfecwuWhQtc22KdX1IixJCwW4YwvH7E/js1f1KLpMQVWiam6dy3Y
 s6VORAPKjy6RccvCI626sjLsf6UJ5+IsSVAZr2k0MwdbE7UPpDA==

Am 21.12.25 um 19:22 schrieb Gladyshev Ilya:

> Implement the basic WMI subsystem abstractions required to write a
> WMI device driver with or without the need for initial device data.
> This includes the following data structures:
>
> The `wmi::Driver` trait represents the interface to the driver.
>
> The `wmi::Device` abstraction represents a `struct wmi_device`.
>
> In order to provide the WMI specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is
> implemented by `wmi::Adapter`.
>
> Everything from C side is supported, except shutdown action
>
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/lib.rs              |   2 +
>   rust/kernel/wmi.rs              | 267 ++++++++++++++++++++++++++++++++
>   3 files changed, 270 insertions(+)
>   create mode 100644 rust/kernel/wmi.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_he=
lper.h
> index a067038b4b42..f9671280c6b5 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -85,6 +85,7 @@
>   #include <linux/usb.h>
>   #include <linux/wait.h>
>   #include <linux/workqueue.h>
> +#include <linux/wmi.h>
>   #include <linux/xarray.h>
>   #include <trace/events/rust_sample.h>
>  =20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f812cf120042..db3e649d26eb 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -151,6 +151,8 @@
>   pub mod uaccess;
>   #[cfg(CONFIG_USB =3D "y")]
>   pub mod usb;
> +#[cfg(CONFIG_ACPI_WMI)]
> +pub mod wmi;
>   pub mod workqueue;
>   pub mod xarray;
>  =20
> diff --git a/rust/kernel/wmi.rs b/rust/kernel/wmi.rs
> new file mode 100644
> index 000000000000..018e88d01e8c
> --- /dev/null
> +++ b/rust/kernel/wmi.rs
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the WMI devices.
> +//!
> +//! C header: [`include/linux/wmi.h`](srctree/include/linux/wmi.h)
> +
> +use crate::{
> +    acpi::AcpiObject,
> +    device,
> +    device_id::{RawDeviceId, RawDeviceIdIndex},
> +    driver,
> +    error::{from_result, to_result, VTABLE_DEFAULT_ERROR},
> +    prelude::*,
> +    types::Opaque,
> +};
> +use core::{
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ptr::{addr_of_mut, NonNull},
> +};
> +use macros::vtable;
> +
> +/// [`IdTable`](kernel::device_id::IdTable) type for WMI.
> +pub type IdTable<T> =3D &'static dyn kernel::device_id::IdTable<DeviceI=
d, T>;
> +
> +/// The WMI driver trait.
> +#[vtable]
> +pub trait Driver: Send {
> +    /// The type holding information about each one of the device ids s=
upported by the driver.
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const TABLE: IdTable<Self::IdInfo>;
> +
> +    /// WMI driver probe.
> +    ///
> +    /// Called when a new WMI device is bound to this driver.
> +    /// Implementers should attempt to initialize the driver here.
> +    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> imp=
l PinInit<Self, Error>;
> +
> +    /// WMI device notify.
> +    ///
> +    /// Called when new WMI event received from bounded device
> +    fn notify(&self, _dev: &Device<device::Core>, _event: &AcpiObject) =
{
> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +
> +    /// WMI driver remove.
> +    fn remove(self: Pin<KBox<Self>>, _dev: &Device<device::Core>) {
> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +}
> +
> +/// A WMI device.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct wmi=
_device`].
> +/// The implementation abstracts the usage of a C [`struct wmi_device`]=
 passed
> +/// in from the C side.
> +pub struct Device<Cxt: device::DeviceContext =3D device::Normal> {
> +    inner: Opaque<bindings::wmi_device>,
> +    _p: PhantomData<Cxt>,
> +}
> +
> +impl<Cxt: device::DeviceContext> Device<Cxt> {
> +    fn as_raw(&self) -> *mut bindings::wmi_device {
> +        self.inner.get()
> +    }
> +}
> +
> +/// An adapter for the registration of WMI drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY: A call to `unregister` for a given instance of `RegType` is =
guaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T>=
 {
> +    type RegType =3D bindings::wmi_driver;
> +
> +    unsafe fn register(
> +        wdrv: &Opaque<Self::RegType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        macro_rules! map_callback {
> +            ($flag:ident -> $callback:ident) =3D> {
> +                if T::$flag {
> +                    Some(Self::$callback)
> +                } else {
> +                    None
> +                }
> +            };
> +        }
> +
> +        // SAFETY: It's safe to set the fields of `struct wmi_driver` o=
n initialization.
> +        unsafe {
> +            (*wdrv.get()).driver.name =3D name.as_char_ptr();
> +            (*wdrv.get()).driver.probe_type =3D bindings::probe_type_PR=
OBE_PREFER_ASYNCHRONOUS;
> +            (*wdrv.get()).id_table =3D T::TABLE.as_ptr();
> +            (*wdrv.get()).probe =3D map_callback!(HAS_PROBE -> probe_ca=
llback);
> +            (*wdrv.get()).notify =3D map_callback!(HAS_NOTIFY -> notify=
_callback);

I think it should be possible to handle WMI drivers requiring .no_notify_d=
ata to be set. Is there
a way to declare the WMI event data passed to the notify() callback as opt=
ional? If yes, then i suggest
that we always set .no_notify_data and simply require the WMI drivers them=
selves to verify that a given
WMI event does contain additional event data.

(Said no_notify_data flag only exists because most WMI drivers currently a=
ssume that the event data
passed to the .notify() callback is not NULL)

Thanks,
Armin Wolf

> +            (*wdrv.get()).remove =3D map_callback!(HAS_REMOVE -> remove=
_callback);
> +            (*wdrv.get()).shutdown =3D None;
> +            (*wdrv.get()).no_singleton =3D true;
> +        }
> +
> +        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
> +        to_result(unsafe { bindings::__wmi_driver_register(wdrv.get(), =
module.0) })
> +    }
> +
> +    unsafe fn unregister(wdrv: &Opaque<Self::RegType>) {
> +        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
> +        unsafe { bindings::wmi_driver_unregister(wdrv.get()) };
> +    }
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    extern "C" fn probe_callback(
> +        wdev: *mut bindings::wmi_device,
> +        id: *const c_void,
> +    ) -> kernel::ffi::c_int {
> +        // SAFETY: The WMI core only ever calls the probe callback with=
 a valid pointer to a
> +        // `struct wmi_device`.
> +        //
> +        // INVARIANT: `wdev` is valid for the duration of `probe_callba=
ck()`.
> +        let wdev =3D unsafe { &*wdev.cast::<Device<device::CoreInternal=
>>() };
> +
> +        let id =3D id as usize;
> +        let info =3D T::TABLE.info(id);
> +
> +        from_result(|| {
> +            let data =3D T::probe(wdev, info);
> +
> +            wdev.as_ref().set_drvdata(data)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    extern "C" fn notify_callback(
> +        wdev: *mut bindings::wmi_device,
> +        obj: *mut bindings::acpi_object,
> +    ) {
> +        // SAFETY: The WMI system only ever calls the notify callback w=
ith a valid pointer to a
> +        // `struct wmi_device`.
> +        let wdev =3D unsafe { &*wdev.cast::<Device<device::CoreInternal=
>>() };
> +        // SAFETY: AcpiObject is repr(transparent) wrapper
> +        let obj: &AcpiObject =3D unsafe { &*(obj as *const AcpiObject) =
};
> +
> +        // SAFETY: `notify_callback` is only ever called after a succes=
sful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_dr=
vdata()` has been called
> +        // and stored a `T`.
> +        let this: &T =3D unsafe { &wdev.as_ref().drvdata_borrow::<T>() =
};
> +        this.notify(wdev, obj);
> +    }
> +
> +    extern "C" fn remove_callback(wdev: *mut bindings::wmi_device) {
> +        // SAFETY: The WMI system only ever calls the remove callback w=
ith a valid pointer to a
> +        // `struct wmi_device`.
> +        let wdev =3D unsafe { &*wdev.cast::<Device<device::CoreInternal=
>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a succes=
sful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_dr=
vdata()` has been called
> +        // and stored a `T`.
> +        let this =3D unsafe { wdev.as_ref().drvdata_obtain::<T>() };
> +        this.remove(wdev);
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<=
Ctx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is =
a pointer to a valid
> +        // `struct platform_device`.
> +        let dev =3D unsafe { addr_of_mut!((*self.inner.get()).dev) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +kernel::impl_device_context_deref!(unsafe { Device });
> +kernel::impl_device_context_into_aref!(Device);
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that =
the refcount is non-zero.
> +        unsafe { bindings::get_device(self.as_ref().as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount =
is non-zero.
> +        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw())=
.dev) }
> +    }
> +}
> +
> +/// Abstraction for the WMI device ID structure, i.e. [`struct wmi_devi=
ce_id`].
> +#[repr(transparent)]
> +pub struct DeviceId(bindings::wmi_device_id);
> +
> +impl DeviceId {
> +    /// Constructs new DeviceId from GUID string
> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -=
> Self {
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut inner: bindings::wmi_device_id =3D unsafe { MaybeUninit=
::zeroed().assume_init() };
> +
> +        build_assert!(inner.guid_string.len() =3D=3D bindings::UUID_STR=
ING_LEN as usize + 1);
> +
> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we valida=
ted lengths
> +        // Also we leave last byte zeroed -> guid_string is valid C str=
ing
> +        unsafe {
> +            ::core::ptr::copy_nonoverlapping(
> +                guid.as_ptr(),
> +                &raw mut inner.guid_string[0],
> +                bindings::UUID_STRING_LEN as usize,
> +            );
> +        }
> +
> +        Self(inner)
> +    }
> +}
> +
> +// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `wmi_devic=
e_id` and does not add
> +// additional invariants, so it's safe to transmute to `RawType`.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType =3D bindings::wmi_device_id;
> +}
> +
> +// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `context` field.
> +unsafe impl RawDeviceIdIndex for DeviceId {
> +    const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings:=
:wmi_device_id, context);
> +
> +    fn index(&self) -> usize {
> +        self.0.context as usize
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single WMI driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// module_wmi_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     author: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_wmi_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::wmi::Adapter<T>, { $($f)* }=
);
> +    }
> +}
> +
> +/// Create a WMI `IdTable` with its alias for modpost.
> +#[macro_export]
> +macro_rules! wmi_device_table {
> +    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $t=
able_data: expr) =3D> {
> +        const $table_name: $crate::device_id::IdArray<
> +            $crate::wmi::DeviceId,
> +            $id_info_type,
> +            { $table_data.len() },
> +        > =3D $crate::device_id::IdArray::new($table_data);
> +
> +        $crate::module_device_table!("wmi", $module_table_name, $table_=
name);
> +    };
> +}

