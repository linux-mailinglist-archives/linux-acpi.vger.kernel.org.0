Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A83829D9
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhEQKd7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 06:33:59 -0400
Received: from m13134.mail.163.com ([220.181.13.134]:49418 "EHLO
        m13134.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhEQKd5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 06:33:57 -0400
X-Greylist: delayed 2774 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 06:33:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Ub0Vf
        0fbH3OL1iEjlbO1lhZp7rlbHcjhdJfIam7T91A=; b=O5AE6P6GZuTUTdACuqeCq
        +fnytb3xy4LPIMO0yrJ8U4a58TpdqkNUg9FiQvUzFP7CLhd9cuX7/mKtg/3DRdet
        FrrcK/emWnYKmStk3GSHUM3Iy7cOfpndcwkrairRKQ8Fuj/3Dtgxk2Xtti95OxRl
        IIP2kxGMDogh5u4ASDiltU=
Received: from wsj20369$163.com ( [211.94.251.182] ) by
 ajax-webmail-wmsvr134 (Coremail) ; Mon, 17 May 2021 17:45:50 +0800 (CST)
X-Originating-IP: [211.94.251.182]
Date:   Mon, 17 May 2021 17:45:50 +0800 (CST)
From:   wsj20369 <wsj20369@163.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Len Brown" <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] Revert "ACPI: power: Turn off unused power resources
 unconditionally"
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0g--YTuzHiMTiVwuEH2Z87k+JCmynqqFshZ70yNXuUHew@mail.gmail.com>
References: <20210430124224.6383-1-wsj20369@163.com>
 <CAJZ5v0g--YTuzHiMTiVwuEH2Z87k+JCmynqqFshZ70yNXuUHew@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <52c748d4.5c2f.17979b7a960.Coremail.wsj20369@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hsGowADHrl9PO6JgiYTjAA--.26943W
X-CM-SenderInfo: hzvmjiqtwzqiywtou0bp/xtbB0hyVF1UMbkoueAACsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CgpBdCAyMDIxLTA1LTE0IDIyOjA1OjA2LCAiUmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj5PbiBGcmksIEFwciAzMCwgMjAyMSBhdCAyOjQzIFBNIFNodWp1biBX
YW5nIDx3c2oyMDM2OUAxNjMuY29tPiB3cm90ZToKPj4KPj4gVGhpcyByZXZlcnRzIGNvbW1pdCA3
ZTRmZGVhZmE2MWYyYjY1M2ZjZjk2NzhmMDk5MzVlNTU3NTZhZWQyLgo+PiBJdCBtYXkgY2F1c2Ug
c29tZSBOVk1lIGRldmljZSBwcm9iZXMgdG8gZmFpbCwgYW5kIHRoZSBzeXN0ZW0gbWF5IGdldAo+
PiBzdHVjayB3aGVuIHVzaW5nIGFuIE5WTWUgZGV2aWNlIGFzIHRoZSByb290IGZpbGVzeXN0ZW0u
Cj4+Cj4+IEluIHRoZSBmdW5jdGlvbiBudm1lX3BjaV9lbmFibGUoc3RydWN0IG52bWVfZGV2ICpk
ZXYpLCBhcyBzaG93biBiZWxvdywKPj4gcmVhZGwoTlZNRV9SRUdfQ1NUUykgYWx3YXlzIHJldHVy
bnMgLTEgd2l0aCB0aGUgY29tbWl0LCB3aGljaCByZXN1bHRzIGluCj4+IHRoZSBwcm9iZSBmYWls
ZWQuCj4+Cj4+ICAgaWYgKHJlYWRsKGRldi0+YmFyICsgTlZNRV9SRUdfQ1NUUykgPT0gLTEpIHsK
Pj4gICAgICAgICByZXN1bHQgPSAtRU5PREVWOwo+PiAgICAgICAgIGdvdG8gZGlzYWJsZTsKPj4g
ICB9Cj4+Cj4+IGRtZXNnOgo+PiAgIFsgICAgMS4xMDYyODBdIG52bWUgMDAwMDowNDowMC4wOiBw
bGF0Zm9ybSBxdWlyazogc2V0dGluZyBzaW1wbGUgc3VzcGVuZAo+PiAgIFsgICAgMS4xMDkxMTFd
IG52bWUgbnZtZTA6IHBjaSBmdW5jdGlvbiAwMDAwOjA0OjAwLjAKPj4gICBbICAgIDEuMTEzMDY2
XSBudm1lIDAwMDA6MDQ6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+IDAwMDIpCj4+ICAg
WyAgICAxLjEyMTA0MF0gbnZtZSBudm1lMDogUmVtb3ZpbmcgYWZ0ZXIgcHJvYmUgZmFpbHVyZSBz
dGF0dXM6IC0xOQo+Pgo+PiBsc3BjaToKPj4gICBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xs
ZXI6IEtJT1hJQSBDb3Jwb3JhdGlvbiBEZXZpY2UgMDAwMQo+Pgo+PiBkZXZpY2UgdWV2ZW50Ogo+
PiAgIERSSVZFUj1udm1lCj4+ICAgUENJX0NMQVNTPTEwODAyCj4+ICAgUENJX0lEPTFFMEY6MDAw
MQo+PiAgIFBDSV9TVUJTWVNfSUQ9MUUwRjowMDAxCj4+ICAgUENJX1NMT1RfTkFNRT0wMDAwOjA0
OjAwLjAKPj4gICBNT0RBTElBUz1wY2k6djAwMDAxRTBGZDAwMDAwMDAxc3YwMDAwMUUwRnNkMDAw
MDAwMDFiYzAxc2MwOGkwMgo+Pgo+PiBUaGlzIHBhdGNoIHdhcyB0ZXN0ZWQgaW4gTGVub3ZvIFRo
aW5rcGFkIFgxLgo+Cj5QbGVhc2Ugc2VuZCBtZSB0aGUgZG1pZGVjb2RlIG91dHB1dCBmcm9tIHRo
aXMgbWFjaGluZSBvciAoYmV0dGVyKQo+YXR0YWNoIGl0IGF0IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjEzMDE5Cj4KPlRoYW5rcyEKCkhpIFJhZmFlbDoKClNv
cnJ5IGZvciBsYXRlLCBJIGhhdmUgYXR0YWNoZWQgdGhlIGFjcGlkdW1wIGFuZCBkbWlkZWNvZGUg
aW4gdGhlIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjEzMDE5
CgpCUgpTaHVqdW4gV2FuZwoK
