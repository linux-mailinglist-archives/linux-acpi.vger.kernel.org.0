Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CCA31FAA
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Jun 2019 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFAOOM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Jun 2019 10:14:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfFAOOM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Jun 2019 10:14:12 -0400
Received: from [192.168.1.110] ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7yz7-1gSn9l1PIx-014y7V; Sat, 01 Jun 2019 16:14:10 +0200
To:     LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: How to inject fwnode/oftree/acpi data by platform driver ?
Organization: metux IT consult
Message-ID: <c15a9872-4ad4-1b7e-e34f-14549b5b55eb@metux.net>
Date:   Sat, 1 Jun 2019 16:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vbfLWOD3UONPL5v9tYMNFKhO32hwAlv2T2wf51k08qhcDR7xnND
 7nfiHZLcbks5p9X2mXYqddIGfRLmwmvBy+rg6ocRhZqy2JTQjiqtzTz95X8ly+j6tP0MIu2
 MPXIK+3tD1P8tL10q2QwVU0bi8UWYiw05foBx+u0BaflR+Ne03h9nrjOA4GmRjNJgO4MAxo
 HFpQ5gQ03IJSrmt2XZRYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0C/Ji8CNAZk=:wNxJLB0sRHA5kdZOd6cYuA
 BFAXfqb26rtNHKbL4EaQuGdgEbRLzR/xPGZA7EdUvb2Yv4+b/MVqtTGl2A4wbjAaKEZEsCPQW
 SaJnqGNXIbheJVB43zL41BgNlmejzxGBGUr/0MyifjGR+hUIcwNy1XFSnYBNf8qIc6etOF/eZ
 BBJBOawe2S+HzScmkdkhZ+sSiuwtvj0CjvE+EBne4KTkqAChKuSJ7/IFbyxq2g6eHhByZzXCn
 YDIjGX15XaQ68et4OIiBWd5PEbXSt2cZLaYwg/mk0LZFnt43PnIF3Y97vJKxp7r0TwtLvsBJA
 nygu/A9rmUvKN1h7pSy3KA+Q+C46pZO2mnviEScIEsJU8Sh+DhB17jYZc3T/yS32QtEsTiwLg
 4DauLHgaYI5gTSVpG3ejhi1vnlm/4ZNq/S/nl+gcvdZRDhf34A+lCCjtOjdGwPn99CCOedkn+
 OZ+yIKfuCGWPrIov5seHyyf0G5HGjnMNIe4eRUCfxpmmYsFhyDr5faABQqXrhYLH/6ukmkGLw
 siBpF0I8cVJay0BAFv9J14NJWYaKCj/K01baAgzhDsfjpy5/y01IPIMkamup7+ipGFFQ1yg3l
 KuhMh2TvCXL6/65gqdO8QmYze2QzoZNjnTvlCsxH8tLFoPobIWP7U1FEZ8enqt/7Ysel5+ld3
 RLeaUOJuaoiq31LlYGvl22dzofDYp5CYkQV8h+W3KAix1kg3E/vGIKq/Jhd1UWb4T74UvA+Dn
 Rg8JCp2lCdJ3mr/oTWyLcb1Go2jFSCMQMJzNg9bGFaq2AEhDaabOSeEyeKE=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi folks,


I'm looking for a way to inject fwnode data from a platform driver,
in order to initialize generic drivers w/ board specific configuration.
The idea is getting rid of passing driver specific pdata structs
(which, IIRC, seem to be deprecated).

An example usecase is the APUv2/3 board, which have things like gpios
wired to buttons and LEDs. The board can only be detected via DMI
string, no way to probe the platform devices - have to be initialized
explicitly (that's how I'm already doing it now).

The nicest way, IMHO, would be if I could just write some piece of DTS
and some fancy magic all the rest under the hood. Such thing doesn't
seem to exist yet. Does it make sense to implement that ? How could
we do it ?

Which other options do we have ?

Or should we just leave everything as it is and stick w/ pdata structs ?


thx
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
