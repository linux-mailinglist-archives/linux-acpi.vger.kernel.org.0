Return-Path: <linux-acpi+bounces-15513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F4B19DE4
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF6F172D13
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903B2417C3;
	Mon,  4 Aug 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dv5z2YO8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A72F2D;
	Mon,  4 Aug 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296969; cv=none; b=iAWPs3XC2LkRmjt+Tm7kfxd4JW8nEmHdhgzqJUy8qXh2JceU+KifaXhXt5haX8LpvoKTpr+py+TvzEcae54ujgUv9XmbQkxpczKkn0pw0M1alWlx3tu12xbn4cHHJCNcQsD513yxy43P0byROJPQ+rFlOoV1NA+shdja2zo2voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296969; c=relaxed/simple;
	bh=L7T2peuzotcxh0WDpbjrWrh+4FLTWHQ/ToB/4BKx620=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2Va8o6F13Q+24PX6GgUeOoipE0nv+0wqx3bVaCCcSHKMNK87DWOSJ1sRNl+/bUv6kpuAU0ol3CBnsc085WBtSee3fojEIm5w8dvctCDW1twpwzb23hY1InB87nQcEA36QDp/7URQTgB35NLRNE9kTG37degeWCffKjIJ2sMag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dv5z2YO8; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754296965; x=1754901765; i=markus.elfring@web.de;
	bh=UASp2Q43xdTYdojg64rqUD6JEddZj16gpDHk948VxA8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dv5z2YO8haLlKOlwNl3UMwlixDWATeNZdkNX1asyYWBvnzi86/AH7OOlmHnm6ClM
	 vLSUDQPK7xEGYRQmCbzDQK1wMmksvre3ZImA/DC61U+fLtMh0heO8QzvTSEbiucBy
	 AGrPhfojTf5LJVylOAMP1D/ywRQ0BnkAQslruvEuy26e2+GnI55MrhgfOyswX+rlc
	 flKdaliwkoclJecdXT4zPyWPqVxLb+Pcn+3/KxXrQwRbVYVoWN0ukeoXGUyRfSPNa
	 INTq2n7Smy6D7pNldWJP1icelyTKFjGZe+/ZwcZVMXj5x+HYA2MjdWApOXJWCC2Rq
	 38WlBwoHwKlghaWoug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCmZ-1uIH4l3BZn-00ch8v; Mon, 04
 Aug 2025 10:42:44 +0200
Message-ID: <43362d25-5be8-4158-bda2-2c8e9c4743f4@web.de>
Date: Mon, 4 Aug 2025 10:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
To: Zhen Ni <zhen.ni@easystack.cn>, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20250730124508.939257-1-zhen.ni@easystack.cn>
 <20250804074115.44573-1-zhen.ni@easystack.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250804074115.44573-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FG44XmFFueVGlehpQaLcXe7bSczvr7xOKVfQst+eEyCEVoQGekn
 AN5fzG/8ePu+J65Vyws4IVDxxlL1FQjdj6bd0nKf1fkYRWtTbTW/9UVaNmn4vn9qNgK+DMY
 KqX+SXR35IR9huFlf7Uk80ozhp0hH2ELc2vmGOlF4VdEbXWKCS/P+WQscMEgcTn24FggFir
 9JAye0ArBnV80p2dTdmBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mz2mULEYJTs=;xL0gWXWXFt1EM9oAeOgynXXjDbE
 iUi9J6bWu9XkExQm36ZuBldjOW+7VXeY7qDnnrIxO7bxhuwXNpsQLYlIKfV8d6vuT3S+Ju77R
 kJbYPi+YbNFT1EKRdJfvll+KDV8FXH65DFvYu7BQsIZO6EsSbddMfzcOs3tGZ/4KSflZ8VhY9
 t+vm4VGIXKLWrm34TCjVpMUBtrEtzzJu+YXyuv1A/Zoc7T3QaUZ9U8dp1w/wQ/VEZHKC8sxM7
 ikeofY5ckM3moAy7tfGF0Vebd0lPeltNI/B7WLbyChm7JgL8q8Hk7tZxuUStLAUh3ulGI4rlI
 izN1sKRXrHvElu0a+MzdjaK/ek/6gL+hIFhuSdl1wwBGXbsoPtqZ4q8AofRCPIUYenJvCtj+g
 lykg/aKqctngL59e1p3Iz/77tV7Y8IlKX3g8VucYAVrEVgDNDvARt64l6/bkSTH9oIOAlBljz
 XtWEX39flKjTxW+PNohJSBq+8enQZNpVYuWtc6tdUSCPx+C38/0UfKoGUUiVJdQTDLW4nswzV
 s5EDUNChci1SDJw19UmJLXijqz9+HY64CCLQI04MoNouFl5NjFezRgzm418k/GdFc+Frd67U5
 wp04y/ZgHquFLXrnSY4JbL6Dh2euS6MFvw09WyZxsIWl00a3rVD3PbbeEE8KJs5rPMS/YI9xh
 l2Za40qhm1BSGqiCgZpqoOrk1KAWlkYxDmCJMtC+2jONozG9J3s/dFGWtw48vM79zrvo1np+x
 qf96Ma4vXgcdwA07JRZds5l2SNgKnOsBSjeFc4TmsD97x6ywc7K+dgASgIEE7HQPmm7rI85dh
 X0fBpzPwPqFaaa6/5XVwfgzR76mYtsC0fw7U1jZYn2jWvkRYXOlEBnC9TS7r9l6I44G5nCziv
 Lqp4Qe06tf7/C18mb5eNeiEBCLLMPgVmjI8v1XjYh27OVhOeknILjY5yBLFXcctaDtFECYc0/
 lJnKy3jJKMXxth7gCo9dWIM5RMJg0DXQKHzbVqXADrspN1uSop63EelKuL9/BFAHE/E7UDUEo
 3w2oc6P22D1BEdQOb17kBsPC3XKVJuLOQSaxqwEder1/dDeXKnuMiAPBsr509WzkdEpLYXwqD
 pgINCEOsnZ6wU0AZZ3m0lM+FmgrI/F58nUstc9FXChD0QqII02IsBjmpBoJrSfjdtYVktdIeO
 9Q3bH/A6hFTKiGB6zsjUro/m36mUmQksx6+xh4/BZ2fuLGIi45a6kw9DjAKTp1v6ga6hUgV7u
 7LLObq+W06tikFgY00uYGnEWBkkkdsXg+dbIYsTMg9qss4rIsh1y4+3zThdva/x6bIJfLd6EY
 JsBDh+MvrHKgAStQyQmHEDvBSksAkrQvqp/1J4Ty8cd/MFZA3nVSBmEmPLGW5UkbqIc6+vCEa
 HzAIEEJOKXqnOp2Zk9eF9BJChPqEgrN0xtxCYQgZLsx5pXs1h+CL7HjqS7d5jz60Zcf0HO5Z3
 HcA9N0JICoh4XYI65AP2Ac+L/ysnssR61xvcPnKTtyYyeF1gh79rWrk8yvu3l/OoVlB0kcJ+D
 fI1Dj9zqyTNKO0qcvZPZk51P5l5BLNOHAMzMwU8kp8Q2VKb9g+wBbc0OkiroBvI5Nyobhfdcx
 +1frBaVl+raZapQGZsDZr49XbEwqJodoQ1gs8tXMnUlPlH4X9XLHegk4lc6Ox9VmHB1puZV4T
 tCJz9ouaTGJqQyXF2MPiRPWRkNP6A6pRSDxh7xVQ2yaeMCrlIMBjOkXmFHxgFYLKhnSLVvOoN
 DzbdOd25D+QPI4vD6DdudJlBrezX9PqR6HtegQOugpuzjT9Ll9yYkY0DUa6amw0O4pzxbOu28
 tSoFK8oIBwHY2g1n271l3jMaV7Xa7GKp28s6Y/toN9wCFW4DMCzTALhBYUF00MAaLzbXzOJTa
 KmmdkwWiZY/ZpXXIcOaLo2IVvhTO34ElM3CpNc0CzR/qDTqm//1dOY8tZ2T5wFCA9oMvIlf23
 GzwUxPdo6hHLz7lXfsqxSnEIx9mDVirn8DaxNgyJ+s13rGILw5FBA7FYKlb65ED5EqcUpzcs/
 wtS6eST5xNJVyaOcTw1vIMISHeYn9U8B2zZzvP7ZNGEwOr27kYDZ8JoNrVtSoahBkbcrhlVlf
 25KneM1qnvxH5xXmHles9bgrZGtnSon6Fg1/yAOBsLJSmWlYfkJgMgMou3akNInzlGTtKL6q8
 ubRtZ+dlS7PcSdZ6hxhErYfWerAtpsirvB78E6FWTAILl6B0/E22oRBgt46Ueigz+x+K6CkbC
 GQwH8+bCXX0zcOzzQJ+wW++HgzGeJJCB/Ng+xuLhb8Fk4vgtJiZlgqUM/EBQDaatVLZlFS4d1
 bTkyZqXQTWUReSYgXNAlbYfs/XkWS4ul7ygDfrSwThcDmS7Wfy+AH4ptvLRFtfwJHE9+s3zfl
 s+dRa8dbKy/r1dUJ9I3ifDlElkp0K0Q1EojaM/5+q/rf1pwaxGML+Ta2I0/z9/z/jNpB6+Lxa
 h2+ory/FDt7pXqJlJNnTfGO/AJWKbVADj3IAHz+ZqW6+ZHoXVZ1it2dhmiPmXy/oWTJ6kA+To
 QNZbZD9/2vN4vkdG3nbKSXRQmuyq2tTnZqzS2ATtGozxuzLTAByujJwI7Bv3DF+VBCSKQvPkS
 xDtHhzfhp70eBPjE42VjdHqKBLxabNmz+TNENeiLDiMwwBCAsBCil+NUE8gC3LHNWJUpNxvml
 nR19s/oZ/AJH+c2243A6LBc7beP0I5LHrbaZXJY/yXyVSuTliqPLrGFdKd5Yzk/L+Zggto0Pg
 sf5VT86tDRitOMvQD4kD6t8Cm/dXRJJRkFpMKPupr3ZZAIxC77XCq7Zee43KEUWbYXaAReBkp
 lyw0dkZ6pVfM6E0EEdMthq2XEyDuq4gqQ4iNQZFaFugFKx+E9munHJUOEuhZQOYQ6fY5ZGJ0O
 6XiJFln7M7123eElkYnazXlwKC020Obt9btaNm5z3HvK7Io6a9r54YGzpbQ8GXs9B99qFxOc7
 Ydit+/xnatJzXCQV4xP9P1KMzL8CRfhGov5psNB8AAhBXrsEbS+G3+umRK7+cjRAYNDVDBn3+
 nfaGJNVFPuG4/pmCyBwIBcLqjQ6CUxK3wXCwapzPdtrdNSPu+n7ca/GN6vX2LZb9Ogf79xogp
 sKpMw3qXRAaOmg4eKrM8Uq9Kw0qgiASOi7/m1VTVvutAWTQ8M9HlT61Jfhl98+7fH6RxNf4lY
 K4QJazDVmPJDOCR8Q1LfJuCG86I3/5Z7tJ7h7KgGSyd3t6oDy4DHLbh2uD5Qfn381pAHQG4W8
 dEx2+vwoWxIXYl58Qqj/0rx+i1Bb/ejs7WxvDadchuvQg0aHBoRJ0nJYVy6g9093RDsC8WFid
 N0i3UWe177JAkQ/Gu1dAr3zPlb3XRgilxtzlXY/iO17YSTHw9V9B6Fvi7vUS1+hfIFvUIkxPJ
 8PF3PxIfXxwSOScTvn/pTlUEh7GDNrRNIq1hdPCa8wi4kc3/5C+bpq4oYCIBY0qfPYyYsluYa
 bMjlqKGybMOosk1yXKbcmblNFgmlHWETxYDzPkxKCfZ841R8x2GxiPJjvDUHxnEKNoUNcnLhA
 0w==

> In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table()
> is only released in error paths but not in the success path. This
> leads to a permanent ACPI memory leak when the driver successfully
> initializes.

* You may occasionally put more than 66 characters into text lines
  of such a change description.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16#n658

* See also once more:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6> ---
> Changes in v2:
> - Add tags of 'Fixes' and 'Cc'
> - Change goto target from out_put_pcct to e_nomem
=E2=80=A6> +++ b/drivers/mailbox/pcc.c
> @@ -763,19 +763,19 @@ static int pcc_mbox_probe(struct platform_device *=
pdev)
>  					 GFP_KERNEL);
>  	if (!pcc_mbox_channels) {
>  		rc =3D -ENOMEM;
> -		goto err;
> +		goto e_nomem;
>  	}
=E2=80=A6

Why do you not move the assignment statement accordingly?


=E2=80=A6> @@ -796,17 +796,17 @@ static int pcc_mbox_probe(struct platform=
_device *pdev)
>  		    !pcc_mbox_ctrl->txdone_irq) {
>  			pr_err("Platform Interrupt flag must be set to 1");
>  			rc =3D -EINVAL;
> -			goto err;
> +			goto e_nomem;
>  		}
=E2=80=A6

You misunderstood one of my development suggestions.


=E2=80=A6> @@ -827,9 +827,8 @@ static int pcc_mbox_probe(struct platform_d=
evice *pdev)
=E2=80=A6> -		return 0;
> -err:
> +
> +e_nomem:
>  	acpi_put_table(pcct_tbl);
>  	return rc;
>  }
Would an other code variant be more reasonable?

e_nomem:
	rc =3D -ENOMEM;
	goto err;


Regards,
Markus

