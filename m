Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1911AE5FE
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Apr 2020 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgDQTlk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Apr 2020 15:41:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:40227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbgDQTlj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Apr 2020 15:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587152490;
        bh=BxSnRRs5hm+cSbHKgqSk/Joew1xaM+/aI7NALrThZ9U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V2k+I/xQiBAwTuKcZ1f3nGmHmG7sQXCbpUIHEnisXLyMce+MzQa4S+NKMx2ls+dWQ
         W5/g2qcq9gbSovJb2DEVkeoIBqm86H+7PT4qUNf+UP96c0hYbdT+iI/T9vCo9gctnl
         2CUfYJkcS+bbN9mhoZJznd9p34ff7Z5JkDs8SYFI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.1.39.83]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1j10jY3JyU-00yDMy; Fri, 17
 Apr 2020 21:41:30 +0200
Subject: Re: regression 5.6.4->5.6.5 at drivers/acpi/ec.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <fdd9ce1d-146a-5fbf-75c5-3a9384603312@gmx.de>
 <5478a950-4355-8084-ea7d-fe8b270bf2e3@infradead.org>
 <5392275.BHAU0OPJTB@kreacher> <4b21c095-fbe5-1138-b977-a505baa41a2b@gmx.de>
 <CAJZ5v0icdVL6_yGpfsorqszdi9GcLxzYdvDqTJyG4ENzkOG2pQ@mail.gmail.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 mQSuBFKhflgRDADrUSTZ9WJm+pL686syYr9SrBnaqul7zWKSq8XypEq0RNds0nEtAyON96pD
 xuMj26LNztqsEA0sB69PQq4yHno0TxA5+Fe3ulrDxAGBftSPgo/rpVKB//d6B8J8heyBlbiV
 y1TpPrOh3BEWzfqw6MyRwzxnRq6LlrRpiCRa/qAuxJXZ9HTEOVcLbeA6EdvLEBscz5Ksj/eH
 9Q3U97jr26sjFROwJ8YVUg+JKzmjQfvGmVOChmZqDb8WZJIE7yV6lJaPmuO4zXJxPyB3Ip6J
 iXor1vyBZYeTcf1eiMYAkaW0xRMYslZzV5RpUnwDIIXs4vLKt9W9/vzFS0Aevp8ysLEXnjjm
 e88iTtN5/wgVoRugh7hG8maZCdy3ArZ8SfjxSDNVsSdeisYQ3Tb4jRMlOr6KGwTUgQT2exyC
 2noq9DcBX0itNlX2MaLL/pPdrgUVz+Oui3Q4mCNC8EprhPz+Pj2Jw0TwAauZqlb1IdxfG5fD
 tFmV8VvG3BAE2zeGTS8sJycBAI+waDPhP5OptN8EyPGoLc6IwzHb9FsDa5qpwLpRiRcjDADb
 oBfXDt8vmH6Dg0oUYpqYyiXx7PmS/1z2WNLV+/+onAWV28tmFXd1YzYXlt1+koX57k7kMQbR
 rggc0C5erweKl/frKgCbBcLw+XjMuYk3KbMqb/wgwy74+V4Fd59k0ig7TrAfKnUFu1w40LHh
 RoSFKeNso114zi/oia8W3Rtr3H2u177A8PC/A5N34PHjGzQz11dUiJfFvQAi0tXO+WZkNj3V
 DSSSVYZdffGMGC+pu4YOypz6a+GjfFff3ruV5XGzF3ws2CiPPXWN7CDQK54ZEh2dDsAeskRu
 kE/olD2g5vVLtS8fpsM2rYkuDjiLHA6nBYtNECWwDB0ChH+Q6cIJNfp9puDxhWpUEpcLxKc+
 pD4meP1EPd6qNvIdbMLTlPZ190uhXYwWtO8JTCw5pLkpvRjYODCyCgk0ZQyTgrTUKOi/qaBn
 ChV2x7Wk5Uv5Kf9DRf1v5YzonO8GHbFfVInJmA7vxCN3a4D9pXPCSFjNEb6fjVhqqNxN8XZE
 GfpKPBMMAIKNhcutwFR7VMqtB0YnhwWBij0Nrmv22+yXzPGsGoQ0QzJ/FfXBZmgorA3V0liL
 9MGbGMwOovMAc56Zh9WfqRM8gvsItEZK8e0voSiG3P/9OitaSe8bCZ3ZjDSWm5zEC2ZOc1Pw
 VO1pOVgrTGY0bZ+xaI9Dx1WdiSCm1eL4BPcJbaXSNjRza2KFokKj+zpSmG5E36Kdn13VJxhV
 lWySzJ0x6s4eGVu8hDT4pkNpQUJXjzjSSGBy5SIwX+fNkDiXEuLLj2wlV23oUfCrMdTIyXu9
 Adn9ECc+vciNsCuSrYH4ut7gX0Rfh89OJj7bKLmSeJq2UdlU3IYmaBHqTmeXg84tYB2gLXaI
 MrEpMzvGxuxPpATNLhgBKf70QeJr8Wo8E0lMufX7ShKbBZyeMdFY5L3HBt0I7e4ev+FoLMzc
 FA9RuY9q5miLe9GJb7dyb/R89JNWNSG4tUCYcwxSkijaprBOsoMKK4Yfsz9RuNfYCn1HNykW
 1aC2Luct4lcLPtg44LQ1VG9yYWxmIEbDtnJzdGVyIChteSAybmQga2V5KSA8dG9yYWxmLmZv
 ZXJzdGVyQGdteC5kZT6IgQQTEQgAKQUCUqF+WAIbIwUJEswDAAcLCQgHAwIBBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEMTqzd4AdulO06EBAIBfWzAIRkMwpCEhY4ZHexa4Ge8C/ql/sBiW8+na
 FxbZAP9z0OgF2zcorcfdttWw0aolhmUBlOf14FWXYDEkHKrmlbkEDQRSoX5YEBAA2tKn0qf0
 kVKRPxCs8AledIwNuVcTplm9MQ+KOZBomOQz8PKru8WXXstQ6RA43zg2Q2WU//ly1sG9WwJN
 Mzbo5d+8+KqgBD0zKKM+sfTLi1zIH3QmeplEHzyv2gN6fe8CuIhCsVhTNTFgaBTXm/aEUvTI
 zn7DIhatKmtGYjSmIwRKP8KuUDF/vQ1UQUvKVJX3/Z0bBXFY8VF/2qYXZRdj+Hm8mhRtmopQ
 oTHTWd+vaT7WqTnvHqKzTPIm++GxjoWjchhtFTfYZDkkF1ETc18YXXT1aipZCI3BvZRCP4HT
 hiAC5Y0aITZKfHtrjKt13sg7KTw4rpCcNgo67IQmyPBOsu2+ddEUqWDrem/zcFYQ360dzBfY
 tJx2oSspVZ4g8pFrvCccdShx3DyVshZWkwHAsxMUES+Bs2LLgFTcGUlD4Z5O9AyjRR8FTndU
 7Xo9M+sz3jsiccDYYlieSDD0Yx8dJZzAadFRTjBFHBDA7af1IWnGA6JY07ohnH8XzmRNbVFB
 /8E6AmFA6VpYG/SY02LAD9YGFdFRlEnN7xIDsLFbbiyvMY4LbjB91yBdPtaNQokYqA+uVFwO
 inHaLQVOfDo1JDwkXtqaSSUuWJyLkwTzqABNpBszw9jcpdXwwxXJMY6xLT0jiP8TxNU8EbjM
 TeC+CYMHaJoMmArKJ8VmTerMZFsAAwUQAJ3vhEE+6s+wreHpqh/NQPWL6Ua5losTCVxY1snB
 3WXF6y9Qo6lWducVhDGNHjRRRJZihVHdqsXt8ZHz8zPjnusB+Fp6xxO7JUy3SvBWHbbBuheS
 fxxEPaRnWXEygI2JchSOKSJ8Dfeeu4H1bySt15uo4ryAJnZ+jPntwhncClxUJUYVMCOdk1PG
 j0FvWeCZFcQ+bapiZYNtju6BEs9OI73g9tiiioV1VTyuupnE+C/KTCpeI5wAN9s6PJ9LfYcl
 jOiTn+037ybQZROv8hVJ53jZafyvYJ/qTUnfDhkClv3SqskDtJGJ84BPKK5h3/U3y06lWFoi
 wrE22plnEUQDIjKWBHutns0qTF+HtdGpGo79xAlIqMXPafJhLS4zukeCvFDPW2PV3A3RKU7C
 /CbgGj/KsF6iPQXYkfF/0oexgP9W9BDSMdAFhbc92YbwNIctBp2Trh2ZEkioeU0ZMJqmqD3Z
 De/N0S87CA34PYmVuTRt/HFSx9KA4bAWJjTuq2jwJNcQVXTrbUhy2Et9rhzBylFrA3nuZHWf
 4Li6vBHn0bLP/8hos1GANVRMHudJ1x3hN68TXU8gxpjBkZkAUJwt0XThgIA3O8CiwEGs6aam
 oxxAJrASyu6cKI8VznuhPOQ9XdeAAXBg5F0hH/pQ532qH7zL9Z4lZ+DKHIp4AREawXNxiGYE
 GBEIAA8FAlKhflgCGwwFCRLMAwAACgkQxOrN3gB26U7PNwEAg6z1II04TFWGV6m8lR/0ZsDO
 15C9fRjklQTFemdCJugA+PvUpIsYgyqSb3OVodAWn4rnnVxPCHgDsANrWVgTO3w=
Message-ID: <d66ad8f1-d7c5-dd8a-0eb4-9e560dc9ada1@gmx.de>
Date:   Fri, 17 Apr 2020 21:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0icdVL6_yGpfsorqszdi9GcLxzYdvDqTJyG4ENzkOG2pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2FtQasdkXOOQSixelBf5RFiuSdpd6nRc27IlFXe+hdGGuZ0VAPh
 orvae4e9mVEND6u5DAw28bOXrWIBIiq6Ba07ERX/eCplqsJ/HOgTn/LPy+Nnz0vi++4jICf
 TXf5pqTnnmtE+C3xtFysRru5KvwP6ie6sl3lUodpTDF3QyyfnRRoyES4aHoOi1p8NllmYNg
 FM4KW+MB71vSszpueyJ8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UntVRQlGeFE=:qm9mNsPUhNnaXnKy4WxV9/
 bm7aIJoRHaFLhSY85jkXKRZUY3D2ouRIfzH+6r+OMILJOaz3mOn8GIzACJx9Awxd/tPjgG0t4
 iNBp41VlZKbyGmiAMtiwM9tRTFV0oB7qPCtCXqnMlBHAzVmkE6JzmAkZ4QtRFGU9wAEQqoajT
 ARkKJRBo+BH1ETGLDFJBAyLGYjOtA+8K3Kuv6UDtrOs7Q8wFIjONxHiJnTPZkHTJJuNzXRbmX
 NhjlQd3yRXNvryw6rtAm5bOkVYmul1lgnXNqdVCswdDF008DMFRwhVzlEh3bDRgdPTUfFpeVL
 20XZWGfddMUPsGiuXe20XMYWbzzCeo+gYruYZ/u6rEgKJfrx0F9jWj3gNNmCeuQkcEE0Hpkbf
 1ej84sWvLTivjCJ/eR/nK56+mrT0kkC5YI643fzArtQe0A9iIqBtLspqG99EAgdvYkxdKXcXa
 xYzv89Z+rIFAKBb//Rb5V1muj47Z9aN2Q1fkdKLgcWneXhtRr0zeUTWGWK9AXArjgff7o20Wv
 SJNkOSk18g1pR9Gdd+/XY17M8N5i3X/4IMVmubabVFJXMjX2mSEMU5TzCLw3k/b8AhbYlnVo2
 oN4k5cAF/XivvN7KXtPmVU+Xr2cGssRm3CD1cOe8ffD0wyhWY6MFkSxU9RCF8ITZx/hKoOScA
 KVIf12ZRMFzdtW0+EJ0u6kZgBjHG4syuvJCU/c7vr7mcsqGiyargWjJKZVy/yHXMYgh8v9VTw
 HPgD4Rm5OJkRaWKpgfGObup/sPCF3TicTZGvWlaF/JSjbsxwRGlu7OgfJmLL0mEKnslOJjUKb
 oGdMNTZTb7zYlX5XJh1PZr6nOtWoEd3NNFVDownUaQC6XOLdPzUecegeUW8qjI1BKjIcZMyaO
 P8tpvdRckJBF0Bg/cHBrH0JrqrdpgI0pCRtBXJKU8Voo1KPb4il+/21m1l7U6odkF/VXRu7ZO
 PaZgGZp+up4dW+7FnKx8qFYPqtEtBYZThwqzhs0dCqq7Ook4pDoZVNLA9JnBGg5JcoEsScbkA
 oO3O++EEa+bOEQZAJqpKkZ9aBeXtXuXxsj/hnwAYN/lGk48g1990cwxuu0ULy/FMCw3wW+PIn
 yN0Zw9xSnX7l6Y/1i6JsTdzGlx0QaglBTuGJWc4kCm4kYSlODnW5UKsMtZW/BVnyQ6LxN9Gg1
 aLajudAUcZL9ram8QqrpqszEsX6sd49zFFx08l2GqX1aQfWxx0DoQ7g+XUBlux5dJG9gRD1PO
 TK314YEY6r0RoT9lk
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/17/20 8:52 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 17, 2020 at 6:36 PM Toralf F=C3=B6rster <toralf.foerster@gmx=
.de> wrote:
>>
>> On 4/17/20 5:53 PM, Rafael J. Wysocki wrote:
>>> Does the patch below (untested) make any difference?
>>>
>>> ---
>>>  drivers/acpi/ec.c |    5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/acpi/ec.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- linux-pm.orig/drivers/acpi/ec.c
>>> +++ linux-pm/drivers/acpi/ec.c
>>> @@ -2067,7 +2067,10 @@ static struct acpi_driver acpi_ec_driver
>>>               .add =3D acpi_ec_add,
>>>               .remove =3D acpi_ec_remove,
>>>               },
>>> -     .drv.pm =3D &acpi_ec_pm,
>>> +     .drv =3D {
>>> +             .probe_type =3D PROBE_FORCE_SYNCHRONOUS,
>>> +             .pm =3D &acpi_ec_pm,
>>> +     },
>>>  };
>>>
>>>  static void acpi_ec_destroy_workqueues(void)
>> I'd say no, but for completeness:
>
> OK, it looks like mainline commit
>
> 65a691f5f8f0 ("ACPI: EC: Do not clear boot_ec_is_ecdt in acpi_ec_add()")
>
> was backported into 5.6.5 by mistake.
>
> Can you please revert that patch and retest?
>
Yes, reverting that commit solved the issue.

=2D-
Toralf
