Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB62863BB
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgJGQXT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 12:23:19 -0400
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:46778
        "EHLO sonic309-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbgJGQXS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2020 12:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602087796; bh=PxMwWzXvs+dqOoH0/FHvFmQpYH2JguaCUHYAVLLmaiw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OpD6sdWmMpCqHH9mdd6ZvDXA8BMNItdBBEhuwaMT76h/ZLwAekJxmf3sL5Tm7F6u5J5Cwz3tNhOynMD0jOIXwmaFKMMySfkal/fGH8C3frbWm3GjElucUfyWIfoQLs+2Acqjwxi8XBSg7us+PxpuSmwx44NQ14JudcHftB4hVpWbttBe4fAY4BfnjSftQacVGKmJzRyL2FbE8Gaw8zXbhokDV7l5wpcFqxc9SWnIBNYmyCEGgU2Vp9OwY9jVjBgFQU3r4J9VcUICkltohTAWyw647+t6CbThr29420FmwAJctvWmP4r3ngo51sgMI//J7rAYi/YTvjIjEPMgLI9DQw==
X-YMail-OSG: qdWaPgcVM1nuXamhTbr65jyGHWDsrGkhJB.qfE.Lfo2FpLfQyyasqNkGf1j47_q
 OJvYA2b6MUUnf9.6qujXe3GeKTTp_MYBehMMmR8oSMUwEkTynKoUjb4klILw5ADfUwW39yqq5xFx
 eUtvnjHRN807W8dSJpFHCTEbJS5XJqvv7k1KMITaVe6OC1wEqpii_1dz5tz7e51Vk0vIG9_Bd_GK
 _TULgsBB844J9ZzJrTwXWorQNmL1jETFenupE9YitzsxHMe3ZaXTNTAzgRfWHrD881PEISLj2KhF
 F0QD3D2DHsEGEg1sV7hoqsJdPm8_tx972v1V.dZk5AfZ6H_rv_W_lKt.nuDTLzkpAaR4qkQHrys4
 ukGn3NqmJw6sBP.ZK53Xf3Blew.gdsdZDg7INoJWCyvkCkAyk6JAhm07wmK3Q7Q0iEgHHesNYRAz
 qJIHop5k0MGBVdIgWf1x0yDbLxKSSHNVuHCnaWvghfkPhenBEHKOREuLxjBdI8v.lEFTkoglm_um
 6YnVPGTU3r.TR8vW6XgA2sN4UdER_JsYoewZlV78qxupoXIozNaoHbA6ucd.Yef4p2_BVHPNTJ70
 vG6YE7aL1ILvluIlRv5lxS77YyFnCHwonGpVHXdaOjcv3pHbUCIGiFHLkv.jUHEQTdJ6KpgxQq2L
 gdBmhuG8T2YkdCB1vv.ZZsQDfGhU50ZzancfNiYVC3i8ca5HGiYOnLmc_4gKN1NGcjFHSwPw_.Rm
 BXHA9w0si3QMc38ea7m16_N8oTx9IEwq.BQJ_1Wjzp7sEQv4J8BxOHlA1ZrOGozutPTbHXLrGr0E
 L_ZLjYhAum7Fh1dHObJgzvogElKK4W5kMy8Q2curCohzVy7mwZqpIk3JZuwUiU3j1sacsOly7iPY
 fJtIz3k11_O1GOYi.wJby7cbFemBwUE82ZDltiNysuKWOhxX0ufGSRjneyt9U6ZVK5a8UxeGHyIX
 __lElV24E72BlLlcPIsh9fXG5YFkeOv78kOi59kVdOB0shwj4cB9Y1x9OIsnG8H.jWqeNTFjSDch
 K6.n8yDBoWyc0g9cdWhZZpQKskoUUUlHwwQkg39gsiEg0vmHwVBcMpflUsO3INGl_yIRmLyo_Rc4
 ivYQ9JVu3YpaNvvCXvdGmLGkGdFlvBYjfgC4zKpNbjojlUB7UvrI7VhiLwxtYRE6NYP1Oa2vDOO5
 .Hh7KZC1SU9vQzQOFJkr8Cd6.FEeE5Tuj0R_CB1JhQXpvtYbPNIetCm1lO7VULS7bjP11BBjiaZA
 d95CwwdG1tHb7J.LnPVBB1C3qNPWEN5U7jSeMrkX.UAI2Vsmy7LUUYH16mQRKSg_rg0y6PWI.mom
 4rR2SzMtRlOZG6j7U_gn95yzLVSc1mpVtw9qC8qHt4C7KJOTKXzNFvx7C5hVvttFe8Gz3hUNCayX
 XRTWYNSirxrh7a9DIALhjNDavLEWMzKLo6MmP
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 16:23:16 +0000
Date:   Wed, 7 Oct 2020 16:23:14 +0000 (UTC)
From:   Marilyn Robert <fredodinga22@gmail.com>
Reply-To: marilyobert@gmail.com
Message-ID: <851832897.153495.1602087794366@mail.yahoo.com>
Subject: =?UTF-8?B?0J3QsNGY0LzQuNC70LAg0LrQsNGYINCz0L7RgdC/0L7QtNCw0YDQvtGC?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <851832897.153495.1602087794366.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCtCd0LDRmNC80LjQu9CwINC60LDRmCDQs9C+0YHQv9C+0LTQsNGA0L7Rgg0KDQrQiNCw0YEg
0YHRg9C8IDY4LdCz0L7QtNC40YjQvdCwINC20LXQvdCwLCDQutC+0ZjQsCDRgdGC0YDQsNC00LAg
0L7QtCDQv9GA0L7QtNC+0LvQttC10L0g0LrQsNGA0YbQuNC90L7QvCDQvdCwINC00L7RmNC60LAs
INC+0LQg0YHQuNGC0LUg0LzQtdC00LjRhtC40L3RgdC60Lgg0LjQvdC00LjQutCw0YbQuNC4LCDQ
vNC+0ZjQsNGC0LAg0YHQvtGB0YLQvtGY0LHQsCDQvdCw0LLQuNGB0YLQuNC90LAg0YHQtSDQstC7
0L7RiNC4INC4INC+0YfQuNCz0LvQtdC00L3QviDQtSDQtNC10LrQsCDQvNC+0LbQtdCx0Lgg0L3Q
tdC80LAg0LTQsCDQttC40LLQtdCw0Lwg0L/QvtCy0LXRnNC1INC+0LQg0YjQtdGB0YIg0LzQtdGB
0LXRhtC4INC60LDQutC+INGA0LXQt9GD0LvRgtCw0YIg0L3QsCDQsdGA0LfQuNC+0YIg0YDQsNGB
0YIg0Lgg0LHQvtC70LrQsNGC0LAg0YjRgtC+INGB0LUg0ZjQsNCy0YPQstCwINC60LDRmCDQvdC1
0LAuINCc0L7RmNC+0YIg0YHQvtC/0YDRg9CzINC/0L7Rh9C40L3QsCDQvdC10LrQvtC70LrRgyDQ
s9C+0LTQuNC90Lgg0L3QsNC90LDQt9Cw0LQg0Lgg0L3QsNGI0LjRgtC1INC00L7Qu9Cz0Lgg0LPQ
vtC00LjQvdC4INCx0YDQsNC6INC90LUg0LHQtdCwINCx0LvQsNCz0L7RgdC70L7QstC10L3QuCDR
gdC+INC90LjRgtGDINC10LTQvdC+INC00LXRgtC1LCDQv9C+INC90LXQs9C+0LLQsNGC0LAg0YHQ
vNGA0YIg0LPQviDQvdCw0YHQu9C10LTQuNCyINGG0LXQu9C+0YLQviDQvdC10LPQvtCy0L4g0LHQ
vtCz0LDRgtGB0YLQstC+Lg0KDQrQlNC+0LDRk9Cw0Lwg0LrQsNGYINCy0LDRgSDQvtGC0LrQsNC6
0L4g0YHQtSDQv9C+0LzQvtC70LjQsiDQt9CwINGC0L7QsCwg0L/QvtC00LPQvtGC0LLQtdC9INGB
0YPQvCDQtNCwINC00L7QvdC40YDQsNC8INGB0YPQvNCwINC+0LQgMiwgMzAwLCAwMDAg0LXQstGA
0LAg0LfQsCDQv9C+0LzQvtGIINC90LAg0YHQuNGA0L7QvNCw0YjQvdC40YLQtSwg0YHQuNGA0L7Q
vNCw0YjQvdC40YLQtSDQuCDQv9C+0LzQsNC70LrRgyDQv9GA0LjQstC40LvQtdCz0LjRgNCw0L3Q
uNGC0LUg0LzQtdGT0YMg0LLQsNGI0LjRgtC1INGB0L7QsdGA0LDQvdC40ZjQsCAvINC+0L/RiNGC
0LXRgdGC0LLQvi4g0JfQsNCx0LXQu9C10LbQtdGC0LUg0LTQtdC60LAg0L7QstC+0Zgg0YTQvtC9
0LQg0LUg0LTQtdC/0L7QvdC40YDQsNC9INCy0L4g0LHQsNC90LrQsCDQutCw0LTQtSDRiNGC0L4g
0YDQsNCx0L7RgtC10YjQtSDQvNC+0ZjQvtGCINGB0L7Qv9GA0YPQsy4gQXBwcmVjaWF0ZdC1INGG
0LXQvdCw0Lwg0LDQutC+INC+0LHRgNC90LXRgtC1INCy0L3QuNC80LDQvdC40LUg0L3QsCDQvNC+
0LXRgtC+INCx0LDRgNCw0ZrQtSDQt9CwINC/0YDQvtC/0LDQs9C40YDQsNGa0LUg0L3QsCDQvNCw
0YHQsNC20LDRgtCwINC90LAg0LrRgNCw0LvRgdGC0LLQvtGC0L4sINGc0LUg0LLQuCDQtNCw0LTQ
sNC8INC/0L7QstC10ZzQtSDQtNC10YLQsNC70Lgg0LfQsCDRgtC+0LAg0LrQsNC60L4g0LTQsCDQ
v9C+0YHRgtCw0L/QuNGC0LUuDQoNCtCR0LvQsNCz0L7QtNCw0YDQsNC8DQrQky3Rk9CwINCc0LXR
gNC40LvQuNC9INCg0L7QsdC10YDRgg==
