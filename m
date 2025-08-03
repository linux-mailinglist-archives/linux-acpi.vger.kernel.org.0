Return-Path: <linux-acpi+bounces-15475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0BB1943E
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 16:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D16173EDD
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A27143756;
	Sun,  3 Aug 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Xtoeaqmh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE202E36E9;
	Sun,  3 Aug 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754231797; cv=none; b=OXW50uJ6UBx+jXMwA7hxZLsiuSiJqcJU3Ms36QixHnrVXf5VGAt6rcTRo4j+CDOLnnZswdh1fZuHHaLnyaLUTlm9kOhBa7mQ/2p9iXfXVbD9gsy5goPioNZNrblT3sOnb/6GBzsMCe+h4HduiyYMQQTt7kYtCfY+M5xOYkz+qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754231797; c=relaxed/simple;
	bh=aqzhN+w/FMkeOQqYq0u4IxBYFCjUFFGrLb3qJGFGSyw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=E7QJ6tSQ+WyN1GqnLbbe7tAfkaUIgTOOMWwMKusBnVM6nFDFhFxxe2mpm0u91FueTFd8wp6Nf+I7uXLZykttN8Xolz3IvbltGII+u7S8WkUoF4wkURipA3xGepj0c3OBeF8v4Vo1TN2k6/P4nCpMhpfi4It5N2COX7zAqquLxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Xtoeaqmh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754231793; x=1754836593; i=markus.elfring@web.de;
	bh=pW07mCiG4VAOuK4mU0xN0EthzqsoruC24cmFWEDWrIs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XtoeaqmhVHrclJc1Zi5Un/6SelyuOwJwX6FrXLfqiqcnvQtPRqEUhdXgAoB0N5JB
	 dGAXtsYimlCjWAOkfcCw1qZF2EAsnYBjmvGCw1JN7yUj39ScQ6aBYJeavNpZfr/qi
	 2CXMA4v8d2uyFdCsyxOZtAWD1Qb60+xwSLJMyoiYj1kYeZpZ5e19PLEsznIoU9LGD
	 w5mqfJQngdrMUP+IIfTTxFM/NIj+V6wwNyox5DXS/b1R8pTG7txFsYhZl3orGBKYK
	 X3ecbPkiozXxUMsKufoVzIlbzvKUkjt7Pb5OXlAU4zO3Rl3vCFGLJPyhyR768nqgz
	 bzoSw6cAunh7dMsqGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1uhkTj3E7n-00Fp6K; Sun, 03
 Aug 2025 16:36:32 +0200
Message-ID: <50cafc07-563e-41a7-9286-54db8a7ac731@web.de>
Date: Sun, 3 Aug 2025 16:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: dikshakdevgan@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20250803113820.16578-1-dikshakdevgan@gmail.com>
Subject: Re: [PATCH] acpi: remove unnecessary paranthesis from return
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250803113820.16578-1-dikshakdevgan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FPrEcxoQbzQaOX4Ew/czgdHuuCzTwgVtw4r50IoE1ZSjxwnQU+1
 7YK6t4uGLcg2Bdt9b0RgeeHrGKruYFCgYOYMrLVGOgnJR2r962hsiHDZUj/AL+u/iqJiIKj
 cZUW2JZ83GytZ0pyyXX32pU5AGyhhQk8YRAVBU8ktI+JeL5ZAThZnCe2tos+K6ZAHAiPNvI
 P9UZo5MKaOYP1J+SjW9mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o1VnUGAg7hI=;hKod2pbES+fODg22LaMZhtd14ph
 w0tYw8eeSiaVuCyfD9wecFJvF618RZXSowim8rdPmK5/ZbO8amDZuSEaLCm6mOawIhdn77XBd
 0r7oEenTlVOm+QigG2qWdXs/9D5xbBOh8hcdP81W7GjoedqubaRICGcedtt8aH69OOHQxXuZ8
 OXEDYrs+XWAUMXkTwW2t0nF/E8OVbCYEMdh0khe466Mn3X+Kt1IMeC4mTxWMUMFUX6gpgrq+d
 +vZFFkzy2YdYHAskJN/xZH3zsRKNrx0WZSqa++ZJCvvI/B/DhY9PhUmF+OADU1YuxXNoSCkls
 0Zh2XUc0I8BdXl+cXATCswEt5ydKJkWBLn3xixQOON5A//h+NRF4+DWtz9wMZq5kI+m9Yi23R
 3lyVrm75e0XAiQXcPVJtNQ8DrP9GO9p8w/fwJ40WZAYoG2W/uFucCmyp1QXSczp7ysqXOFTmc
 mTXGkZ35rQ/u+r1NG+P7k0R6PrML5hhsJasZ+BTMXziQz8dI/HIu7GAGAT1+KbbOHeNLtIy70
 rcMxywV0EjBn0RDGW2pDsyYGrNBVTz1l/L2seK06TQTveo0f0J89VdUdeJCcOYyPGoGEafOb5
 CXnsoHEM/n1GA+7h79kbaY9aJxPio9QJZSljb9U/S5RTaBLJcLyXoyNHGkjUSlZGU4A+ESWS2
 E31qCC1JBvNxJq6AVPnQR6jMQM4GoM/OhUs8MrkihuEVfxJqynqLGKdD76OzzBX96F59LDMy0
 crGQA3ZzGl5Bpq/kaSvolHvIXayCHKgrEt77kGiKsd8Jq5Llr2SMJ10A4Y/XN4hylpGUupM6H
 Ge+OfQroeVhL3lA+DApSMW0yJvx2HqjZslHqwmrsVdcyGUcKwQDF8tIqQ6+Uz/rcsh1VkJVkl
 OQVsPywM1qga0bIHQ0WjI9T3eTLOEJEQr41ceH9rmUTFglyifeFNC8sFR62eKkd5CDN1xg7Kq
 TX8FJuC1BTTEIxQAFyTaBpLYhARgc5nofvwgYJ9CTxs1Pq1fnEWU2rMqXZ4YtCV9eoihTV/bg
 9wboRwhqNsmdAY3BisSkxC3FUHCyoMgPoanXL/uWKPRaEUGRj69VWiRbu3mFFF9okCUs9aScj
 w+b39V/GSyacpQBPQ9zDtBwTxTdn6Y37ItsZp03uEiuINC775xkSdeAHUEkbEWulq+9yiLsJM
 OCQBUb1yFw3RTvcOWJz56xqbRzi0U1pvSI47f2VjDB4LB64sWi6e1svG13hQmv7MhVLDqv0By
 m3Nr7tcy7n/LSc9xOZq78YBjnu3lMlzENzUGxKP9CD9C8e6lI8eh8j+1CWsEZtZU++8ViONwb
 htCph/+JiwY5qOH2d+gurT/p3Fmb7rVDBfuJmmcfKFDi5XEgcBoaZF2c4/abg53HnRqWiFdyj
 y2M/pP1OZqn6KEBD2gJsX7OnzEXNyC0I1b7qMB5KiTl2gzkRRXU3ZnMb1xnc2zcuhZPOS1GQR
 vmfM2EmvB2vKEQmkao1W/AYv5hNDugPR/5iBrpRXElX/LshUo0dgLv7qu5P1BR5g/qMPQNlJd
 QObL1+yoQ7d6T5HPRanub6UNMy875JQ7FoSh4vJ9oFjuixriKs8Jb0SoPEjw2oVXoo53/i18/
 wVaOFM92m9vjGwHLXdGvKCjZ2mXYKVs7ZPAb7iqHcpDHCeaGtQwJ18oNzYRqylBd+c85n9oYS
 cF1LmYX07vPQvIJfOanFUsyADNRVZbVZV9dBy1rchLJng+9m/LaGXTQE3hsm+WRyuDFhV7kBL
 DeCNGLF8shQU7w6RSzL8R+jXXNkKtBciqC5zy+CskJHynyW6xcZlAfDWlgFttLQ7bjSZpK9Ib
 IkG0UZpzVqTBkzY1Vi/33TlYmT7wFzjUCrTcqHr0nY/fdA5xJouYcjmvxXwvX+B93MciDuigQ
 8nf5FELglR9QicrW+F+efa65Lm93FmJX0XddNvgFg4sbxD1UXNSGIi6rRXr5nwAMBmJrQNyrO
 Aq2sPf8kfMZweV2N4LDQHkV9dSYjf5k859tE8WRwBq8VwLczr22zoW/VkHryhOWzdo9BnRdUk
 TpIvI7hlItAjXVh2thZ7Ab+UWbAon6M9iQwOAkKBEt880H8bEPCVJoJ97VVUyGqjzyVtIUqSD
 ZIaspADsXN5xLCqqgP67Zj5X6MLEW0Hqr8n5bosCLG8fMyIjB7yLq81wT/fE71NTW7Nsdm+wo
 9aDZQYdK8Yz0rdxZbhHChyDNEG2RYLOYPixvdeuHh4KUVl4JZwQ4jIG5fSDoVviO1+cnxSrp1
 70LchZ6jA3PYlhszDMXzHruU46P1Uzdt9f+AQCqi9NejORt3QPXHFQoIcXmBHyx4JYYd12yO1
 GmLwvYcgTWvKYyfWtam5HM68YobpHsJ6MQuVlCkiSMcR/oobeYuAA+C541/T/+GG8Ll0Q1Qa3
 k0+JKwixTs/+tCm7ESfSfAfmP4CIdL1YbQeZEn8bieqOKWNRwRrd3th6par/UpVJr0Rh5YYfP
 M76Rx8n1y8rax/2KuEt8jn0N6BAgdfV0ed24MC70ot2wEmbS30qRE4kFe0TlDMnRNHVNn7xNH
 RH/7nOaXJwO6NSbvqHh0vxaPV2+Lf9YZtvsC/FrG1neo/RRNzcM9rmnSdSd6/iAOGEOBbJkDp
 wDtiL7/urTb6u9c5s2t6vm3/1eITD1Y7SC7chvYIPfW1BhQf/nxH6tcbwtxlhfBek4mO5NCcG
 c6OR4JBjyuRr3P0Bbny5UPDdzgAgLUdCDBPRBNogA7vVtA/dnL/z90HTQjNlOoTl9ccIQO6Tn
 KZ7eskE+73ZzJiUiwiW17lmXNICHMqjORCzcFGf595MPHOtEduzbX+SeIRcrIVmtik4RjQ76S
 vHipuqwL+A0JzEVT8EGZq8Gwf52b0GcdteXAAdVYMuj94G5mZXpxUqVJt+CK37HDWXitXKeX1
 16jenOULl+eXozQldEwxrvv7NZksn6/BW9dU9OclXQ0oxOKmnvSheo4DUvTdyFL046o1ffjJB
 k8gSvOaYENUtPPOjBDm2d2QXtwewOweuzVlO9zqSCmptilQWz1+NqIKPM9gVo4NTV13FCC6m4
 QnJTJAyVxAYimhY1s9/LLhUiWIKXmjIWCgW2Q9J/Ff/8ZEPPSqh7YCdd1y88zWvDxwNpXqPpD
 VGucZpC/CjC5jqN92Ibsffg8U1iw6wjvBg2CR66ZC2iY2Dv5nu55q5Onj2tQnG6HQJuFiWa9P
 +EMNDApbG/KA7CPq0NUFLzDF+1G87kwKwPRIMMtgB6Llot5p8dPZ3KdSiMtvHgEg9yD16Z1wa
 pZ1XVgqQDOe1bLersX8NiNvkG8nEFEeNiU+i8ENkOdkcZDz2KldwB4FtelSgEQzX95exkGol7
 6a4zjp2kRuLP9LEKmBNttV8KfhCNdkA2I9lbEdrkF13Au++7JPatGgyvCfnupL8mJGh6tSe4Z
 bOyq2Tv7IxIt2z3P1LN3KJ2hN3COrLKGHI4JugJoNwzOD9VxC1CRlFaxYD4HvS5jnzDIM2xkU
 NtbNTDXj5ryPpLyKcbr6WomFJ30gAwgcz1LctjU9ZA6xxAb1pi1vD

> checkpatch.pl is generating a warning when return value is
> enclosed in paranthesis. Remove the paranthesis to improve
=E2=80=A6

              parenthesis?

You may occasionally put more than 58 characters into text lines
of such a change description.

Please avoid a typo also in the summary phrase.


=E2=80=A6
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -32,7 +32,7 @@ acpi_status acpi_db_hex_char_to_value(int hex_char, u8=
 *return_value)
>  	/* Digit must be ascii [0-9a-fA-F] */
> =20
>  	if (!isxdigit(hex_char)) {
> -		return (AE_BAD_HEX_CONSTANT);
> +		return AE_BAD_HEX_CONSTANT;
>  	}
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.16#n197

Regards,
Markus

