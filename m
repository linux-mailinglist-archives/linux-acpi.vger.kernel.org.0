Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA37F55A
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfHBKqD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 06:46:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57612 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbfHBKpy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2019 06:45:54 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id badbf9746cbeff85; Fri, 2 Aug 2019 12:45:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v3 0/8] PM / ACPI: sleep: Additional changes related to suspend-to-idle
Date:   Fri, 02 Aug 2019 12:33:05 +0200
Message-ID: <5997740.FPbUVk04hV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgQWxsLAoKPiA+IE9uIHRvcCBvZiB0aGUgIlNpbXBsaWZ5IHRoZSBzdXNwZW5kLXRvLWlkbGUg
Y29udHJvbCBmbG93IiBwYXRjaCBzZXJpZXMKPiA+IHBvc3RlZCBwcmV2aW91c2x5Ogo+ID4gCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzcxMDg1MjIwLno2RktrdllRUFhAa3JlYWNo
ZXIvCj4gPiAKPiA+IHNhbml0aXplIHRoZSBzdXNwZW5kLXRvLWlkbGUgZmxvdyBldmVuIGZ1cnRo
ZXIuCj4gPiAKPiA+IEZpcnN0IG9mZiwgZGVjb3VwbGUgRUMgd2FrZXVwIGZyb20gdGhlIExQUzAg
X0RTTSBwcm9jZXNzaW5nIChwYXRjaCAxKS4KPiA+IAo+ID4gTmV4dCwgcmVvcmRlciB0aGUgY29k
ZSB0byBpbnZva2UgTFBTMCBfRFNNIEZ1bmN0aW9ucyA1IGFuZCA2IGluIHRoZQo+ID4gc3BlY2lm
aWNhdGlvbi1jb21wbGlhbnQgb3JkZXIgd2l0aCByZXNwZWN0IHRvIHN1c3BlbmRpbmcgYW5kIHJl
c3VtaW5nCj4gPiBkZXZpY2VzIChwYXRjaCAyKS4KPiA+IAo+ID4gRmluYWxseSwgcmVhcnJhbmdl
IGxwczBfZGV2aWNlX2F0dGFjaCgpIChwYXRjaCAzKSBhbmQgYWRkIGEgY29tbWFuZCBsaW5lCj4g
PiBzd2l0Y2ggdG8gcHJldmVudCB0aGUgTFBTMCBfRFNNIGZyb20gYmVpbmcgdXNlZC4ACj4gCj4g
VGhlIHYyIGlzIGJlY2F1c2UgSSBmb3VuZCBhIChtaW5vcikgYnVnIGluIHBhdGNoIDEsIGRlY2lk
ZWQgdG8gdXNlIGEgbW9kdWxlCj4gcGFyYW1ldGVyIGluc3RlYWQgb2YgYSBrZXJuZWwgY29tbWFu
ZCBsaW5lIG9wdGlvbiBpbiBwYXRjaCA0LiAgQWxzbywgdGhlcmUKPiBhcmUgNCBuZXcgcGF0Y2hl
czoKPiAKPiBQYXRjaCA1OiBTd2l0Y2ggdGhlIEVDIG92ZXIgdG8gcG9sbGluZyBkdXJpbmcgIm5v
aXJxIiBzdXNwZW5kIGFuZCBiYWNrCj4gZHVyaW5nICJub2lycSIgcmVzdW1lLgo+IAo+IFBhdGNo
IDY6IEVsaW1pbmF0ZSBhY3BpX3NsZWVwX25vX2VjX2V2ZW50cygpLgo+IAo+IFBhdGNoIDc6IENv
bnNvbGlkYXRlIHNvbWUgRUMgY29kZSBkZXBlbmRpbmcgb24gUE1fU0xFRVAuCj4gCj4gUGF0Y2gg
ODogQWRkIEVDIEdQRSBkaXNwYXRjaGluZyBkZWJ1ZyBtZXNzYWdlLgAKClRoZSB2MyBpcyBqdXN0
IGEgcmVhcnJhbmdlZCB2MiBzbyBhcyB0byBtb3ZlIHRoZSBwb3N0IHNlbnNpdGl2ZSBwYXRjaCAo
cHJldmlvdXMgcGF0Y2ggMikKdG8gdGhlIGVuZCBvZiB0aGUgc2VyaWVzLiAgIFtBZnRlciBhcHBs
eWluZyB0aGUgZnVsbCBzZXJpZXMgdGhlIGNvZGUgaXMgdGhlIHNhbWUgYXMgYmVmb3JlLl0KCkZv
ciBlYXNpZXIgdGVzdGluZywgdGhlIHNlcmllcyAoYWxvbmcgd2l0aCBzb21lIHByZXZpb3VzIHBh
dGNoZXMgZGVwZW5kZWQgb24gYnkgaXQpCmlzIGF2YWlsYWJsZSBpbiB0aGUgcG0tczJpZGxlLXRl
c3RpbmcgYnJhbmNoIG9mIHRoZSBsaW51eC1wbS5naXQgdHJlZSBhdCBrZXJuZWwub3JnOgoKaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmFmYWVsL2xpbnV4
LXBtLmdpdC9sb2cvP2g9cG0tczJpZGxlLXRlc3RpbmcKClBsZWFzZSByZWZlciB0byB0aGUgY2hh
bmdlbG9ncyBmb3IgZGV0YWlscy4KClRoYW5rcywKUmFmYWVsCgoKCg==




